require "uri"

module VideoHelper
  def youtube_key
    if youtube.nil?
      nil
    else
      uri = URI::parse youtube
      query = Hash[URI::decode_www_form(uri.query)]
      query["v"]
    end
  end

  def main_youtube_key
    if main_youtube.nil?
      nil
    else
      uri = URI::parse main_youtube
      query = Hash[URI::decode_www_form(uri.query)]
      query["v"]
    end
  end

  def search_link
    text = URI.encode_www_form_component(band?.name + " " + name + " full album")
    {
      "title" => band?.name + " - " + name,
      "url" => "https://www.youtube.com/results?search_query=" + text
    }
  end

  def youtube_thmbnail
    "http://i.ytimg.com/vi/#{youtube_key}/mqdefault.jpg"
  end
end
