class App < Sinatra::Base
  get "/sites" do
    sites = GROCK::Site.all
    erb :sites, locals: {items: sites}
  end

  get "/site/new" do
    site = GROCK::Site.new
    erb :site, locals: {item: site, method: "post"}
  end

  get "/site/:code" do |code|
    site = GROCK::Site.find_by(code: code)
    erb :site, locals: {item: site, method: "put"}
  end

  post "/site/new" do
    p params
    p 11111112
    p params[:entry]
    ActiveRecord::Base.transaction do
      item = GROCK::Site.create(params[:entry])
      p 11111113
      params[:links].values.transpose.map do |values|
        h = params[:links].keys.zip(values).to_h
        h["kind"] = "site"
        h["code"] = item.code
        GROCK::Link.create(h) unless h["url"].empty?
      end
      params[:tags].values.transpose.map do |values|
        h = params[:tags].keys.zip(values).to_h
        h["kind"] = "site"
        h["code"] = item.code
        GROCK::Tag.create(h) unless h["key"].empty?
      end
      h = params[:image]
      h["kind"] = "site"
      h["code"] = item.code
      GROCK::Image.create(h)
    end
    redirect "/site/#{params[:entry]["code"]}"
  end

  put "/site/:code" do |code|
    p params
    ActiveRecord::Base.transaction do
      item = GROCK::Site.update(code, params[:entry])
      GROCK::Link.where(kind: "site", code: code).delete_all
      params[:links].values.transpose.map do |values|
        h = params[:links].keys.zip(values).to_h
        h["kind"] = "site"
        h["code"] = item.code
        GROCK::Link.create(h) unless h["url"].empty?
      end
      GROCK::Tag.where(kind: "site", code: code).delete_all
      params[:tags].values.transpose.map do |values|
        h = params[:tags].keys.zip(values).to_h
        h["kind"] = "site"
        h["code"] = item.code
        GROCK::Tag.create(h) unless h["key"].empty?
      end
      GROCK::Image.where(kind: "site", code: code).delete_all
      h = params[:image]
      h["kind"] = "site"
      h["code"] = item.code
      GROCK::Image.create(h)
    end
    redirect "/site/#{code}"
  end

  get "/site/:code/feed" do |code|
    site = GROCK::Site.find_by(code: code)

    links = GROCK::Link.where(kind: "site", code: code, type: "feed")
    p 1111
    p links
    links.each do |link|
      begin
        source = open(link.url).read
      rescue => e
        error = e.to_s
      end

      m = GROCK::Source.create(
        kind: "site",
        code: code,
        type: :rss,
        url: link.url,
        source: source,
        error: error
      )
      unless m.valid?
        GROCK::Source.create(
          kind: "site",
          code: code,
          url: url,
          error: m.errors.messages.to_s
        )
      end
    end

    redirect "/site/#{code}"
  end
end
