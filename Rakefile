require "sinatra/activerecord/rake"
require "sassc"

task :sass do
  css = Dir.chdir("styles") do
    sass = File.read("index.scss")
    SassC::Engine.new(sass, style: :compressed).render
  end
  File.write("docs/assets/style.css", css)
end

task :start do
  system "rackup -p 4567"
end
