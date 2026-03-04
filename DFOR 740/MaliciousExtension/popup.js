chrome.storage.local.get(["status"], (result) => {
  const msg = document.getElementById("msg");
  if (result.status === "complete") {
    msg.textContent = "You should not have installed this extension.";
    msg.style.color = "red";
  } else {
    msg.textContent = "Initialising system components...";
  }
});