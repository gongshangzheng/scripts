{
  function getSelectedText() {
    var html = "";
    var sel = window.getSelection();
    if (sel.rangeCount) {
      var container = document.createElement("div");
      for (var i = 0, len = sel.rangeCount; i < len; i++) {
        container.appendChild(sel.getRangeAt(i).cloneContents());
      }
      html = container.innerHTML;
    }

    var dataDom = document.createElement("div");
    dataDom.innerHTML = html;
    ['p', 'h1', 'h2', 'h3', 'h4'].forEach(function (tag) {
      dataDom.querySelectorAll(tag).forEach(function (item) {
        var content = item.innerHTML.trim();
        if (content.length > 0) {
          item.innerHTML = content + '<br>';
        }
      });
    });

    return dataDom.innerText.trim();
  }

  // const OPENAI = {
  //   API_KEY: "sk-Jlqw3VNRB6cRbEbGRgvqCHgvS9c4K9jU8J1b6gCoit7EHEJ3", // 替换为你的OpenAI API密钥
  //   MODEL: "gpt-4o",
  //   API_URL: "https://api.chatanywhere.org/v1/chat/completions",
  // };
  const OPENAI = {
    API_KEY: "sk-80b0aa04580e488f8bd5da534f55ea4a", // 替换为你的 DeepSeek API 密钥
    MODEL: "deepseek-chat",  // DeepSeek 常用模型名称（请根据实际需求调整）
    API_URL: "https://api.deepseek.com/v1/chat/completions", // DeepSeek 的 API 端点
  };

  async function callOpenAI(text) {
    const prompt = `
  Please generate a concise comment in Chinese that summarizes its content in one sentence based on the following annotation text, using up to 40 words and not including anything in your output such as 'this annotation says' or "the annotation discusses" or any introductory phrases like "the annotation says":
  ${text}
  `;

    const data = {
      model: OPENAI.MODEL,
      messages: [
        { role: "system", content: "You are a helpful assistant for generating comments on annotations." },
        { role: "user", content: prompt },
      ],
      max_tokens: 1000,
      temperature: 0.2,
    };

    try {
      const response = await fetch(OPENAI.API_URL, {
        method: 'POST',
        headers: {
          'Authorization': `Bearer ${OPENAI.API_KEY}`,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(data),
      });

      if (response.ok) {
        const result = await response.json();
        return {
          success: true,
          result: result.choices[0].message.content.trim(),
        };
      } else {
        const errorData = await response.json();
        return {
          result: errorData.error ? errorData.error.message : 'Unknown error',
          success: false,
        };
      }
    } catch (error) {
      return {
        result: error.message,
        success: false,
      };
    }
  }

  function formatForOrgRoam(title, text, comment) {
    return `
${text}
-------------------------------------
${comment}
  `;
  }

  async function main() {
    var url = location.href;
    var title = document.title;
    const text = getSelectedText();

    let commentResult;
    let success;
    try {
      ({ result: commentResult, success } = await callOpenAI(text));
    } catch (error) {
      console.error('Error calling OpenAI API:', error);
      commentResult = "API call failed";
      success = false;
    }

    if (success) {
      var body = formatForOrgRoam(title, text, commentResult);
    } else {
      var body = getSelectedText();
    }

    var protocolUrl = 'org-protocol://roam-ref?template=r'
        + '&ref=' + encodeURIComponent(url)
        + '&title=' + encodeURIComponent(title)
        + '&body=' + encodeURIComponent(body);

    location.href = protocolUrl;
  }

  main().catch(console.error);
}
