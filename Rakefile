require "sinatra/activerecord/rake"
require "sassc"

task :sass do
  sass = File.read("styles/index.scss")
  css = SassC::Engine.new(sass, style: :compressed).render
  File.write("docs/assets/style.css", css)
end

task :start do
  system "rackup -p 4567"
end
