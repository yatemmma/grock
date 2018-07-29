class App < Sinatra::Base
  get "/admin/feeds" do
    items = GROCK::Feed.all
    erb_admin :feeds, locals: {items: items, title: "Admin | Feeds"}
  end
end
