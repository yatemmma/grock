class App < Sinatra::Base

  get "/:types.html" do |types|
    case types
    when "bands"
      @items = Band.all_items.select {|x| (x.member_of.empty? && x.ex_member_of.empty?)}
      erb :bands, {title: "Bands", search_data: Band.search_json}
    when "members"
      @items = Band.all_items.reject {|x| (x.member_of.empty? || x.ex_member_of.empty?)}
      erb :bands, {title: "Members", search_data: Band.search_json}
    else
      clazz = Object.const_get(types.singularize.capitalize)
      @items = clazz.all_items
      erb types.to_sym, {title: types.capitalize, search_data: clazz.search_json}
    end

  end

  # get "/bands.html" do
  #   erb :bands, {title: "Bands"}
  # end

  get "/:type/new" do |type|
    clazz = Object.const_get(type.capitalize)
  	@item = clazz.new
    erb type.to_sym, {title: "New #{type.capitalize}"}
  end

  # get "/band/new" do
  #   @band = Band.new
  #   erb :band, {title: "New Band", label: @band}
  # end

  get "/:type/:id.html" do |type, id|
    clazz = Object.const_get(type.capitalize)
    @item = clazz.find_by(code: id)
    erb type.to_sym, {title: @item.name}
  end

  # get "/band/:id.html" do |id|
  #   @band = Band.find_by(code: id)
  #   erb :band, {title: @band.name, label: @band}
  # end


  post "/:type/create/:id" do |type, id|
    params.delete("type")
    clazz = Object.const_get(type.capitalize)
    @item = clazz.create(params)
    @item.save
    redirect "/#{type}/#{URI.escape(id)}.html"
  end

  # post "/band/create/:id" do |id|
  #   @band = Band.create(params)
  #   @band.save
  #   redirect "/band/#{URI.escape(id)}.html"
  # end

  post "/:type/update/:id" do |type, id|
    params.delete("type")
    clazz = Object.const_get(type.capitalize)
    @item = clazz.find_by(code: id)
    @item.update(params)
    @item.save
    redirect "/#{type}/#{URI.escape(id)}.html"
  end

  # post "/band/update/:id" do |id|
  #   @band = Band.find_by(code: id)
  #   @band.update(params)
  #   @band.save
  #   redirect "/band/#{URI.escape(id)}.html"
  # end

  post "/:type/delete/:id" do |type, id|
    clazz = Object.const_get(type.capitalize)
    @item = clazz.find_by(code: id)
    @item.destroy
    redirect "/#{type.pluralize}.html"
  end

  # post "/band/delete/:id" do |id|
  #   @band = Band.find_by(code: id)
  #   @band.destroy
  #   redirect "/bands.html"
  # end
end
