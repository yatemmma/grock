let player = null

function initPlaylist(id, keys) {
    // see: https://developers.google.com/youtube/iframe_api_reference
    const element = document.querySelector("#" + id)
    if (element !== null) {
        player = new YT.Player(id, {
            width: "100%",
            height: "100%",
            // see: https://developers.google.com/youtube/player_parameters?hl=ja
            playerVars: {
                autoplay: 1,
                playsinline: 1,
                enablejsapi: 1,
                playlist: keys
            },
            events: {
                'onReady': onPlayerReady,
                'onStateChange': onPlayerStateChange,
                'onError': onPlayerError
            }
        })
    }
}

function setPlaylist(keys) {
    if (player) {
        player.cuePlaylist(keys)
        setTimeout(()=>{player.playVideo()}, 1000)
    } else {
        initPlaylist("player1", keys)
    }
}

function onPlayerReady(event) {
    console.log("onPlayerReady", event)
    event.target.playVideo()
}

function onPlayerStateChange(event) {
    console.log("onPlayerStateChange", event)
}

function onPlayerError(error) {
    console.log("onPlayerError", error)
    if (error.data == 101 || error.data == 150) {
        const list = player.getPlaylist()
        if (player.getPlaylistIndex() < list.length-1) {
            setTimeout(()=>{player.nextVideo()}, 2000)
        }
    }
}

const offsetTop = document.getElementById("player1").offsetTop
window.addEventListener('scroll', () => {
    if (window.innerWidth < 481) {
        const scroll = document.documentElement.scrollTop || document.body.scrollTop
        if (scroll > offsetTop) {
            document.getElementById("player1").classList.add("fixed")
            document.getElementById("player-shadow").classList.remove("hidden")
        } else {
            document.getElementById("player1").classList.remove("fixed")
            document.getElementById("player-shadow").classList.add("hidden")
        }
    }
})

function clickEffect(e) {
    e.style.opacity = 0.5
    setTimeout(()=>{
        e.style.opacity = 1
    }, 100)
}