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

  post "/label/create/:id" do |id|
    @label = Label.create(params)
    @label.save
    redirect "/label/#{URI.escape(id)}.html"
  end

  post "/label/update/:id" do |id|
    @label = Label.find_by(code: id)
    @label.update(params)
    @label.save
    redirect "/label/#{URI.escape(id)}.html"
  end

  post "/label/delete/:id" do |id|
    @label = Label.find_by(code: id)
    @label.destroy
    redirect "/labels.html"
  end
end
