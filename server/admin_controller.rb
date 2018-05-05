class App < Sinatra::Base

  get "/admin" do
    erb :admin, {title: "Admin Console"}
  end
end
