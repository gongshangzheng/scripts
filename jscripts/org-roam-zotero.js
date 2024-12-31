/**
 * A description of this script.
 * @author gongshangzheng
 * @usage Automatically put your annotation in Zotero into emacs org-roam file;自动将 Zotero 中的注释导入到 emacs org-roam 文件中。
 * @link https://github.com/windingwind/zotero-actions-tags/discussions/
 * @see https://github.com/windingwind/zotero-actions-tags/discussions/
 */
if (!item) return; // Exit if no item is provided.
// 如果未提供项目，则退出。

if (!item.isAnnotation()) return "[Action: Send to org-roam] Not an annotation item.";
// If the item is not an annotation, return a message.
// 如果项目不是注释，则返回消息。

return await sendAnnotationToOrgRoam(item);
// Asynchronously call the function to send the annotation to org-roam.
// 异步调用函数，将注释发送到 org-roam。

async function sendAnnotationToOrgRoam(annotationItem) {
  if (!annotationItem.annotationText) return "[Action: Send to org-roam] No text found in this annotation.";
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

  const formattedAnnotation = formatForOrgRoam(documentTitle, annotationText);
  // Format the annotation content for org-roam.
  // 格式化注释内容以供 org-roam 使用。

  const result = await pushToOrgRoam(formattedAnnotation, documentTitle);
  // Push the formatted annotation to org-roam.
  // 将格式化后的注释推送到 org-roam。

  return result.message;
  // Return the result message.
  // 返回推送结果消息。
}

function formatForOrgRoam(title, text) {
  const timestamp = new Date().toISOString();
  // Get the current timestamp.
  // 获取当前时间戳。

  return `
  ${text}
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

