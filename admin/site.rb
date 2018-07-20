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
    
  end

  put "/site/:code" do |code|
    erb :site, locals: {item: site}
  end
end
