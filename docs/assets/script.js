function toggleMenu() {
  const nav = document.querySelector("header > nav")
  const menu = document.querySelector("#menu")
  if (nav.style.display == "block") {
    nav.style.display = "none"
    menu.text = "Menu"
  } else {
    nav.style.display = "block"
    menu.text = "Close"
  }
}

function ajaxRequest(url, callback) {
  const xhr = new XMLHttpRequest()
  xhr.onreadystatechange = function() {
    if (xhr.readyState == XMLHttpRequest.DONE) {
       if (xhr.status == 200) {
         callback(xhr.responseText)
       }
    }
  }
  xhr.open("GET", url, true)
  xhr.send()
}
