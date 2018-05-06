class App < Sinatra::Base

  get "/admin" do
    erb :admin, {title: "Admin Console"}
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
