class App < Sinatra::Base
  get "/admin/labels" do
    items = GROCK::Label.all
    erb_admin :labels, locals: {items: items, title: "GROCK-Admin | Labels"}
  end

  get "/admin/label/new" do
    item = GROCK::Label.new
    erb_admin :"label", locals: {item: item, method: "post"}
  end

  get "/admin/label/:code" do |code|
    item = GROCK::Label.find_by(code: code)
    erb_admin :label, locals: {item: item, method: "put", title: "GROCK-Admin | #{item.name}"}
  end


  post "/admin/label/new" do
    p params
    p 11111112
    p params[:entry]
    ActiveRecord::Base.transaction do
      item = GROCK::Label.create(params[:entry])
      p 11111113
      params[:links].values.transpose.map do |values|
        h = params[:links].keys.zip(values).to_h
        h["kind"] = "label"
        h["code"] = item.code
        GROCK::Link.create(h) unless h["url"].empty?
      end
      params[:tags].values.transpose.map do |values|
        h = params[:tags].keys.zip(values).to_h
        h["kind"] = "label"
        h["code"] = item.code
        GROCK::Tag.create(h) unless h["key"].empty?
      end
      h = params[:image]
      h["kind"] = "label"
      h["code"] = item.code
      GROCK::Image.create(h)
    end
    redirect "/admin/label/#{params[:entry]["code"]}"
  end

  put "/admin/label/:code" do |code|
    p params
    ActiveRecord::Base.transaction do
      item = GROCK::Label.update(code, params[:entry])
      GROCK::Link.where(kind: "label", code: code).delete_all
      params[:links].values.transpose.map do |values|
        h = params[:links].keys.zip(values).to_h
        h["kind"] = "label"
        h["code"] = item.code
        GROCK::Link.create(h) unless h["url"].empty?
      end
      GROCK::Tag.where(kind: "label", code: code).delete_all
      params[:tags].values.transpose.map do |values|
        h = params[:tags].keys.zip(values).to_h
        h["kind"] = "label"
        h["code"] = item.code
        GROCK::Tag.create(h) unless h["key"].empty?
      end
      GROCK::Image.where(kind: "label", code: code).delete_all
      h = params[:image]
      h["kind"] = "label"
      h["code"] = item.code
      GROCK::Image.create(h)
    end
    redirect "/admin/label/#{code}"
  end
end
