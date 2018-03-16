(function(){
  addInputChangeListener()
  setYoutubeVideo()
})()
function addInputChangeListener() {
  Array.from(document.querySelectorAll("input")).forEach((element)=>{
    element.addEventListener('change', function(event){
      filter(event.target.className.split("-")[1], event.target.value)
    })
    element.addEventListener('keypress', function(event){
      filter(event.target.className.split("-")[1], event.target.value + event.key)
    })
    element.addEventListener('keyup', function(event){
      if (event.keyCode == 46 || event.keyCode == 8) {
        filter(event.target.className.split("-")[1], event.target.value)
      }
    })
  })
}

function toggleMenu(){
  const ul = document.querySelector("header > ul")
  ul.classList.toggle("default");
  ul.classList.toggle("popup");
}

function filter(key, value){
  if (filltered[key] == value) {
    return
  }
  filltered[key] = value

  const $rows = document.querySelectorAll(".items tbody tr")
  $rows.forEach(($row, i)=>{
    if (originals[i][key].toLowerCase().indexOf(value.toLowerCase()) >= 0) {
      $row.style.display = ""
    } else {
      $row.style.display = "none"
    }
  })
}

function sort(key){
  const reverse = !(reversed[key])
  reversed[key] = reverse

  const items = []
  if (displayed == null) displayed = originals.concat([])
  displayed.forEach((item, index)=>{
    const obj = Object.assign({}, item)
    obj.index = index
    items.push(obj)
  })

  const sorted = items.sort((a, b)=> {
    const objA = a[key].toString().toUpperCase()
    const objB = b[key].toString().toUpperCase()
    if (objA < objB) {
      return -1 * (reverse ? -1 : 1)
    }
    if (objA > objB) {
      return 1 * (reverse ? -1 : 1)
    }
    return 0
  })

  const $rows = document.querySelectorAll(".items tbody tr")
  const $tbody = document.querySelector(".items tbody")
  while ($tbody.firstChild) {
    $tbody.removeChild($tbody.firstChild)
  }
  displayed = sorted.map((item)=>{
    $tbody.appendChild($rows[item.index])
    delete item.index
    return Object.assign({}, item)
  })
}

function setYoutubeVideo(){
  const element = document.querySelector("#player")
  if (element === null) {
    return
  }
  const tag = document.createElement("script")
  tag.src = "https://www.youtube.com/iframe_api"
  const firstScriptTag = document.getElementsByTagName("script")[0]
  firstScriptTag.parentNode.insertBefore(tag, firstScriptTag)

  function onYouTubeIframeAPIReady() {
    new YT.Player("player", {
      width: "100%",
      height: "100%",
      videoId: element.getAttribute('data-key'),
      playerVars: {
          playsinline: 1 // インライン再生を指定
      },
      events: {
          "onReady": onPlayerReady,
          "onStateChange": onPlayerStateChange
      }
    })
  }

  function onPlayerReady(evt) {
      // evt.target.mute(); // 自動再生できるようにミュートする
      //evt.target.playVideo(); // ミュートしてから再生のメソッド叩く
      // setTimeout(()=>{
      //   evt.target.unMute();
      // }, 5000)
  }

  function onPlayerStateChange(evt) {
      // if (evt.data === YT.PlayerState.ENDED) { // 再生終了を検知
      //     evt.target.playVideo();
      // }
  }
  window.onYouTubeIframeAPIReady = onYouTubeIframeAPIReady; // iframeのreadyをグローバルにする
}