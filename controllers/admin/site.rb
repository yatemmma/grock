class App < Sinatra::Base
  get "/admin/sites" do
    sites = GROCK::Site.all
    erb_admin :sites, locals: {items: sites, title: "GROCK-Admin | Sites"}
  end

  get "/admin/site/new" do
    site = GROCK::Site.new
    erb :"admin/site", :layout => :"admin/layout", locals: {item: site, method: "post"}
  end

  get "/admin/site/:code" do |code|
    site = GROCK::Site.find_by(code: code)
    erb_admin :site, locals: {item: site, method: "put", title: "GROCK-Admin | #{site.name}"}
  end


  post "/admin/site/new" do
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

  put "/admin/site/:code" do |code|
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
end
