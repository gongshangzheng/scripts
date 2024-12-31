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

return await generateAnnotationComment(item);

async function generateAnnotationComment(annotationItem) {
  if (!annotationItem.isAnnotation()) return "[Action: AI Generate Comment] Not an annotation item.";
  if (!annotationItem.annotationText) return "[Action: AI Generate Comment] No text found in this annotation.";

  const annotationText = annotationItem.annotationText;
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
