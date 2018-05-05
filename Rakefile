require "sinatra/activerecord/rake"
require "sassc"

require "./utils/generator"

task :sass do
  css = Dir.chdir("styles") do
    sass = File.read("index.scss")
    SassC::Engine.new(sass, style: :compressed).render
  end
  File.write("docs/assets/style.css", css)
end

task :html do
  Generator.new.output_index
end

task :start do
  system "bundle exec rackup -p 4567"
end
