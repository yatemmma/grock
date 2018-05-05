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
