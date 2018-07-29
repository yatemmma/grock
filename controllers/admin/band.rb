class App < Sinatra::Base
  get "/admin/bands" do
    items = GROCK::Band.all
    erb_admin :bands, locals: {items: items, title: "Admin | Bands"}
  end
end
