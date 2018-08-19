class App < Sinatra::Base
  get "/admin/sources" do
    items = GROCK::Source.order("created_at DESC")
    erb_admin :sources, locals: {items: items, title: "Admin | Sources"}
  end
end
