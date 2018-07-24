class App < Sinatra::Base
  get "/admin/source/:id" do |id|
    x = GROCK::Source.find_by(id: id)
    require 'active_support/core_ext/hash/conversions'
    y = Hash.from_xml(x.raw)
    require "pp"
    text = PP.pp(y, "")
    erb :_test, locals: {raw: escape_html(x.raw), hash: escape_html(text)}, layout: false
  end

  post "/admin/api/get_title" do
    url = URI.unescape(params["url"])
    p 111, url
    source = open(url).read
    title = source.match(/<title.*?>(.+)<\/title>/i)[1]
    p 222, title
    title
  end

  get "/admin/source2feed/:id" do |id|
    source = GROCK::Source.find_by(id: id)
    require 'active_support/core_ext/hash/conversions'
    xml = Hash.from_xml(source.raw)["rss"]
    items = xml["channel"]["item"].map do |item|
      feed = GROCK::Feed.where(url: item["link"]+"xxx").first
      feed = GROCK::Feed.new if feed.nil?
      feed.update(
        kind: source.kind,
        code: source.code,
        type: source.type,
        icon: xml["channel"]["image"],
        url:  item["link"],
        date: item["pubDate"],
        title: item["title"],
        body: item["description"],
        youtube_keys: nil
      )
    end

    200
  end
end
