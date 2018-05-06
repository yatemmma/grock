class App < Sinatra::Base

  get "/labels.html" do
    erb :labels, {title: "Labels"}
  end

  get "/label/:id.html" do |id|
    @label = Label.find_by(code: id)
    erb :label, {title: @label.name, label: @label}
  end
end
