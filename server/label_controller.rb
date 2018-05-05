class App < Sinatra::Base
  get "/labels.html" do
    @labels = Label.all
    erb :labels, {title: "Labels", labels: @labels}
  end
end
