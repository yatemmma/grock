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
end
