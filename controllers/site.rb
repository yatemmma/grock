class App < Sinatra::Base
  get "/sites" do
    sites = GROCK::Site.all
    erb :sites, locals: {items: sites}
  end

  get "/site/:code" do |code|
    site = GROCK::Site.find_by(code: code)
    erb :site, locals: {item: site}
  end
end
