class App < Sinatra::Base

  get "/labels.html" do
    erb :labels, {title: "Labels"}
  end

  get "/label/new" do
    @label = Label.new
    erb :label, {title: "New Label", label: @label}
  end

  get "/label/:id.html" do |id|
    @label = Label.find_by(code: id)
    erb :label, {title: @label.name, label: @label}
  end
end
