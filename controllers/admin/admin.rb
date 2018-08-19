require_relative "./band"
require_relative "./disc"
require_relative "./feed"
require_relative "./label"
require_relative "./site"
require_relative "./source"

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
    source = open(url, "Accept-Language" => "en-US").read
    title = source.match(/<title.*?>(.+)<\/title>/im)[1]
    hash = {
      title: URI.encode(title.gsub("\n", "").strip).gsub("&amp;", "&")
    }
    p hash
    if url.start_with?("https://www.facebook.com/")
      matches = source.scan(/src=\"([^\"]*)\" [^<]* aria-label=\"([^\"]*)\" role=\"img\"/im)
      matches.each_with_index do |m, i|
        icon_url, icon_title = m
        hash["image_i#{i}"] = "#{icon_title} #{icon_url.gsub("&amp;", "&")}"
      end
      key = url.split("/").compact.reject(&:empty?).pop
      url = "https://www.facebook.com/pg/#{key}/about/?ref=page_internal"
      source = open(url, "Accept-Language" => "en-US").read
      matched = source.match(/<div[^>]*>Genre<\/div><div[^>]*>([^<]*)<\/div>/im)
      p 222, matched
      hash[:genres] = matched[1].gsub("\n", "").strip unless matched.nil?
      matched = source.match(/<div[^>]*>Hometown<\/div><div[^>]*>([^<]*)<\/div>/im)
      p 333, matched
      hash[:origin] = matched[1].gsub("\n", "").strip unless matched.nil?
    end

    if url.start_with?("https://en.wikipedia.org/")
      matched = source.match(/<th[^>]*>Founded<\/th><td[^>]*>([^<]*)</im)
      hash[:founded] = matched[1].gsub("\n", "").strip unless matched.nil?
      matched = source.match(/<th[^>]*>Country of origin<\/th><td[^>]*>([^<]*)</im)
      hash[:country] = matched[1].gsub("\n", "").strip unless matched.nil?
      matched = source.match(/<th[^>]*>Location<\/th><td[^>]*>([^<]*)</im)
      hash[:location] = matched[1].gsub("\n", "").strip unless matched.nil?
      matched = source.match(/src=\"(\/\/upload[^\"]*)\"/im)
      hash[:image1] = "https:" + matched[1].gsub("\n", "").strip unless matched.nil?
      matched = source.match(/srcset=\"(\/\/upload[^\"]*)\"/im)
      hash[:image2] = "https:" + matched[1].gsub("\n", "").strip unless matched.nil?
      matched = source.match(/<th[^>]*>Genre<\/th><td[^>]*>(.*)<\/td>/im)
      hash[:genres] = matched[1].gsub("\n", "").scan(/<a [^>]*>([^<]*)<\/a>/m).flatten.join("/") unless matched.nil?
    end

    hash.to_json
  end


  get "/admin/source2feed/:id" do |id|
    source = GROCK::Source.find_by(id: id)
    require 'active_support/core_ext/hash/conversions'

    if source.url == "https://www.theprp.com/feed/"
      xml = Hash.from_xml(source.raw)["rss"]
      items = xml["channel"]["item"].map do |item|
        feed = GROCK::Feed.where(url: item["link"])
        if feed.nil?
          feed = GROCK::Feed.new
        end

        body = item["description"].split("The post ").first
        p 222, body
        feed.update_all(
          kind: source.kind,
          code: source.code,
          type: source.type,
          icon: nil,
          url:  item["link"],
          date: item["pubDate"],
          title: item["title"],
          body: body,
          categories: item["category"].reject{|x| ["Featured","Reviews","News"].include?(x)}.join(","),
          youtube_keys: nil
        )
      end
      source.update(parsed: true  )
    else

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
    end

    200
  end

  get "/admin/all_feed" do
    links = GROCK::Link.where(type: "feed")
    links.each do |link|
      GROCK::Crawler.get_source(link)
    end
    redirect "/admin/"
  end

  get "/admin/:kind/:code/feed" do |kind, code|
    links = GROCK::Link.where(kind: kind, code: code, type: "feed")
    links.each do |link|
      GROCK::Crawler.get_source(link)
    end
    redirect "/admin/#{kind}/#{code}"
  end
end
