class App < Sinatra::Base

  get "/bands.html" do
    erb :bands, {title: "Bands"}
  end
end
