require "./utils/importer"
require "./utils/site"

class App < Sinatra::Base

  get "/admin" do
    erb :admin, {title: "Admin Console"}
  end

  get "/admin/api/site_title" do
    Site.get_title(URI.unescape(params["url"]))
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
