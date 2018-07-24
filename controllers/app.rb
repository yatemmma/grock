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
    erb_admin :index, locals: {title: "GROCK Admin"}
  end
end

require_relative "./admin/site"
require_relative "./site"
