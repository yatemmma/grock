class App < Sinatra::Base
  get "/sites" do
    sites = Site.all
    erb :sites, locals: {items: sites}
  end

  get "/site/:code" do

  end

  post "/site/new" do

  end

  put "/site/:code" do

  end
end
