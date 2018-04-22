module TemplateHelper
  def partial(name, locals = {})
    erb "partials/#{name}".to_sym, locals: locals[:locals]
  end

  def link(path)
    "./#{"../"*@floor}#{path}"
  end

  def admin?
    true
  end

  def all_items(clazz, codes)
    (codes || "").split(",").map{|x| clazz.find_by(code: x)}
  end

  def all_relations(clazz, column, code)
    code.nil? ? [] : clazz.where("#{column} LIKE ?", "%#{code}%").all
  end

  def youtube_key(url)
    if (url.nil? || url.empty?)
      nil
    else
      uri = URI::parse(url)
      query = Hash[URI::decode_www_form(uri.query)]
      query["v"]
    end
  end

  def genre_labels
    {
      "indie_rock" => "Indie Rock",
      "cover" => "Cover",
      "post-hardcore" => "Post-Hardcore",
      "xmas" => "Christmas"
    }
  end

  def site_labels
    {
      "apple" => "Apple Music",
      "play" => "Google Play",
      "spotify" => "Spotify",
      "soundcloud" => "SoundCloud",
      "bandcamp" => "Bandcamp",
      "youtube" => "YouTube",
      "website" => "Website",
      "wikipedia" => "Wikipedia",
      "twitter" => "Twitter",
      "facebook" => "Facebook",
      "instagram" => "Instagram",
      "purevolume" => "PureVolume",
      "myspace" => "MySpace",
      "lastfm" => "Last.fm",
      "discogs" => "Discogs",
      "teaser" => "Teaser",
      "playlist" => "Playlist",
      "search" => "Search",
      "link" => "Link"
    }
  end

  def disc_types
    {
      "album" => "Album",
      "ep" => "EP",
      "single" => "Single",
      "video" => "Video",
      "lyric" => "Lyric Video",
      "song" => "Song"
    }
  end

  def date_labels
    {
      "month_early" => "Early",
      "month_mid" => "Mid",
      "month_late" => "Late",
      "month_any" => "",
      "spring" => "Spring",
      "summer" => "Summer",
      "fall" => "Fall",
      "winter" => "Winter",
      "year_early" => "Early",
      "year_mid" => "Mid",
      "year_late" => "Late",
      "year_any" => ""
    }
  end

  def band_sites
    %w(apple play spotify soundcloud bandcamp youtube website wikipedia twitter facebook instagram purevolume myspace lastfm discogs)
  end

  def label_sites
    %w(website wikipedia youtube twitter facebook)
  end

  def disc_sites
    %w(apple play spotify soundcloud bandcamp amazon lastfm discogs teaser playlist search)
  end

  def link_and_title(url_text)
    words = url_text.split(" ")
    url = words.shift
    title = words.empty? ? url : words.join(" ")
    [url, title]
  end

  def search_link(type_sym, word)
      text = URI.encode_www_form_component(word)
      case type_sym
      when :google
        "https://www.google.co.jp/search?q=" + text
      when :youtube
        "https://www.youtube.com/results?search_query=" + text
      else
        nil
      end
  end
end
