/**
 * Generate Comments for New Annotations
 * This script generates a comment for each annotation upon its creation using the OpenAI API.
 *
 * @usage Automatically triggered on annotation creation.
 * @link https://github.com/windingwind/zotero-actions-tags/discussions/269
 */

/** { 👍 "openai" } service provider */
const SERVICE = "openai";
// OpenAI API configuration
const OPENAI = {
  API_KEY: "sk-Jlqw3VNRB6cRbEbGRgvqCHgvS9c4K9jU8J1b6gCoit7EHEJ3", // Replace with your OpenAI API key.
  MODEL: "gpt-4o", // Default model name, which can be changed as needed.
  API_URL: "https://api.chatanywhere.org/v1/chat/completions", // Request address, which can be changed as needed.
};

if (!item) return;

if (!item.isAnnotation()) return "[Action: Send to org-roam] Not an annotation item.";
// If the item is not an annotation, return a message.
// 如果项目不是注释，则返回消息。

return await generateAnnotationCommentAndSendToOrgRoam(item);

async function generateAnnotationCommentAndSendToOrgRoam(annotationItem) {
  if (!annotationItem.isAnnotation()) return "[Action: AI Generate Comment] Not an annotation item.";
  if (!annotationItem.annotationText) return "[Action: AI Generate Comment] No text found in this annotation.\n[Action: Send to org-roam] No text found in this annotation.";
  // If there is no text in the annotation, return a message.
  // 如果注释中没有文本，则返回提示信息。

  const Zotero = require("Zotero");
  const Zotero_Tabs = require("Zotero_Tabs");
  const itemID = Zotero_Tabs._tabs[Zotero_Tabs.selectedIndex].data.itemID;
  // Get the ID of the currently selected item.
  // 获取当前选中项的 ID。

  const articleItem = Zotero.Items.get(itemID);
  const annotationText = annotationItem.annotationText;
  const documentTitle = articleItem.getField("title") || "Untitled Document";
  // Get the title of the article; if no title is available, set it to "Untitled Document".
  // 获取文章标题，若无标题则设置为“Untitled Document”。
  let commentResult;
  let success;

  switch (SERVICE) {
    case "openai":
      ({ result: commentResult, success } = await callOpenAI(annotationText));
      break;
    default:
      commentResult = "Service Not Found";
      success = false;
  }

  if (success) {
    annotationItem.annotationComment = commentResult;
    const formattedAnnotation = formatForOrgRoam(documentTitle, annotationText, commentResult);
    // Format the annotation content for org-roam.
    // 格式化注释内容以供 org-roam 使用。
    const result_org_roam = await pushToOrgRoam(formattedAnnotation, documentTitle);
    await annotationItem.saveTx();
    //console.log(`Annotation Comment Created: ${commentResult}`);
    return `Generated Comment: ${commentResult}`;
  } else {
    //console.error(`[Action: AI Generate Comment] Error: ${commentResult}`);
    return `Error: ${commentResult}`;
  }
}

async function callOpenAI(text) {
  const prompt = `
  Please generate a concise comment in Chinese that summarises its content in one sentance based on the following annotation tex, use up to 20 words and do not include anything in your ouput such as 'this annotation says' or "the annotation discusses'or any introductory phrases like "the annotation says":
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
    const xhr = await Zotero.HTTP.request(
      "POST",
      OPENAI.API_URL,
      {
        headers: {
          'Authorization': `Bearer ${OPENAI.API_KEY}`,
          'Content-Type': 'application/json; charset=utf-8',
        },
        body: JSON.stringify(data),
        responseType: "json",
      }
    );

    if (xhr && xhr.status && xhr.status === 200 && xhr.response.choices && xhr.response.choices.length > 0) {
      return {
        success: true,
        result: xhr.response.choices[0].message.content.trim(),
      };
    } else {
      return {
        result: xhr.response.error ? xhr.response.error.message : 'Unknown error',
        success: false,
      };
    }
  } catch (error) {
    //console.error('Error calling OpenAI API:', error);
    return {
      result: error.message,
      success: false,
    };
  }
}
function formatForOrgRoam(title, text, comment) {
  //const timestamp = new Date().toISOString();
  // Get the current timestamp.
  // 获取当前时间戳。

  return `
  ${text}
  -------------------------------------
  ${comment}
  `;
  //return `
//* Annotation for ${title}
  //- Annotation: ${text}
  //- Created on: ${timestamp}
  //`;
  // Format and return the annotation content.
  // 格式化并返回注释内容。
}
async function pushToOrgRoam(formattedAnnotation, title) {
  // Construct org-protocol URL.
  // 构建 org-protocol URL。
  const orgProtocolUrl = `org-protocol://roam-ref?template=r&ref=&title=${encodeURIComponent(title)}&body=${encodeURIComponent(formattedAnnotation)}`;

  try {
    // Simulate a GET request to trigger the system handler (configured via xdg-mime).
    // 模拟 GET 请求，触发系统处理器（通过 xdg-mime 配置）。
    const response = await Zotero.HTTP.request("GET", orgProtocolUrl);

    // If successfully triggered.
    // 如果成功触发。
    if (response && response.status && response.status === 200) {
      return {
        success: true,
        message: `Annotation sent successfully to org-roam with title: ${title}`,
        // Message indicating the annotation was successfully sent to org-roam with the given title.
        // 消息表明注释已成功发送到 org-roam，标题为 ${title}。
      };
    } else {
      return {
        success: false,
        message: `Failed to trigger org-protocol. Response status: ${response.status}`,
        // Message indicating failure to trigger org-protocol, with the response status.
        // 消息表明未能触发 org-protocol，并显示响应状态。
      };
    }
  } catch (error) {
    // Error handling.
    // 错误处理。
    return {
      success: false,
	  message: ""
      //message: `Error triggering org-protocol: ${error.message}`,
      // Message indicating an error occurred while triggering org-protocol, including the error message.
      // 消息表明触发 org-protocol 时发生错误，并显示错误信息。
    };
  }
}

