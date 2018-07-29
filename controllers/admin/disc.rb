class App < Sinatra::Base
  get "/admin/discs" do
    items = GROCK::Disc.all
    erb_admin :discs, locals: {items: items, title: "Admin | Discs"}
  end
end
