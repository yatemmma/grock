require "sinatra/base"
require "sinatra/reloader"

require "./models/_models"
require "./services/_services"

class App < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  helpers do
    def erb_admin(template_name, options={})
      options[:layout] = :"admin/layout" unless options.key? :layout
      erb "admin/#{template_name}".to_sym, options
    end
  end

  enable :method_override
  set :views, "#{settings.root}/../views"
  set :public_folder, "#{settings.root}/../public"

  get "/" do
    erb :index, locals: {title: "GROCK"}
  end

  get "/admin/" do
    sources = GROCK::Source.order("created_at DESC")
    erb_admin :index, locals: {title: "GROCK Admin", sources: sources}
  end
end

require_relative "./admin/admin"
require_relative "./admin/site"
require_relative "./admin/label"
require_relative "./site"
