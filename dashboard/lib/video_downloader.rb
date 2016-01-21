class VideoDownloader
  def initialize
  end
  
  def download(url)
    # depend on youtube-dl https://github.com/rg3/youtube-dl/tree/master/youtube_dl
    system "youtube-dl #{url} --audio-format best --extract-audio"
  end
end
