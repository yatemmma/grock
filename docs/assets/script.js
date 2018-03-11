function toggleMenu(){
  const ul = document.querySelector("header > ul")
  ul.classList.toggle("default");
  ul.classList.toggle("popup");
}

function youtube(){
  (function() {

      "use strict";

      var tag = document.createElement("script"),
          firstScriptTag = document.getElementsByTagName("script")[0];

      tag.src = "https://www.youtube.com/iframe_api";
      firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

      function onYouTubeIframeAPIReady() {
          new YT.Player("player", {
              width: 320,
              height: 240,
              videoId: "YpKAZ3-POow",
              playerVars: {
  //                autoplay: 1, // 再生時にミュートしてないといけないので、パラメータではなくメソッドを利用する
  //                loop: 1, // プレイリストにしか聞かないのでonPlayerStateChange内でplayVideoを叩く
                  playsinline: 1 // インライン再生を指定
              },
              events: {
                  "onReady": onPlayerReady,
                  "onStateChange": onPlayerStateChange
              }
          });
      }

      function onPlayerReady(evt) {
          // evt.target.mute(); // 自動再生できるようにミュートする
          evt.target.playVideo(); // ミュートしてから再生のメソッド叩く
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

  })();
}
