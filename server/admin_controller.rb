require "./utils/importer"
require "./utils/site"
require "./utils/crowler"

class App < Sinatra::Base

  get "/admin" do
    erb :admin, {title: "Admin Console"}
  end

  get "/admin/api/site_title" do
    Site.get_title(URI.unescape(params["url"]))
  end

  get "/admin/api/update_feed" do
    feed = Crowler.new(params["model"], params["code"])
    feed.update
    200
  end

  get "/admin/all_feed" do
    Band.all.each do |item|
      feed = Crowler.new("band", item.code)
      feed.update
    end
    Label.all.each do |item|
      feed = Crowler.new("label", item.code)
      feed.update
    end
    200
  end

  get "/admin/gen_html" do
    @is_admin = false
    Generator.new.output_list_page
    Generator.new.output_pages
    @is_admin = true
    200
  end

  post "/admin/api/settings" do
    setting = Setting.find_by(code: params["code"])
    setting.json = params["json"]
    setting.save
    200
  end

  get "/admin/api/export" do
    Importer.export(params["model"])
    200
  end

  get "/admin/api/import" do
    Importer.import(params["model"])
    200
  end
end
