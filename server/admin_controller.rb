class App < Sinatra::Base

  get "/admin" do
    erb :admin, {title: "Admin Console"}
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
