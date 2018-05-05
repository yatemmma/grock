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

function ajaxRequest(url, params, callback) {
  const xhr = new XMLHttpRequest()
  xhr.onreadystatechange = function() {
    if (xhr.readyState == XMLHttpRequest.DONE) {
       if (xhr.status !== 200) console.log(xhr.status)
       callback(xhr.responseText)
    }
  }
  if (params) {
    url += '?' + Object.keys(params).reduce((a,k)=>{
      a.push(k + '=' + encodeURIComponent(params[k]))
      return a
    }, []).join('&')
  }
  xhr.open("GET", url, true)
  xhr.send()
}
