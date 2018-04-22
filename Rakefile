require "sinatra/activerecord/rake"
require "sassc"

require "./server/app"

task :sass do
  Dir.chdir("templates/styles/") do
    sass = File.read("index.scss")
    css = SassC::Engine.new(sass, style: :compressed).render
    File.write("../../public/assets/style.css", css)
  end
end
