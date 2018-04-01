require "fileutils"
require "./binder-rack/core/rakefile"
require "./binder-rack/grock/grock"

task :build do
  case ARGV[1]
  when "html"
    GROCK::GROCK.new.gen_html

  when "assets"
    org = "binder-rack/grock/html"
    dist = "docs"
    dist_admin = "docs_admin"

    system "bundle exec sass -r sass-css-importer #{org}/styles/index.scss #{org}/assets/style.css"

    FileUtils.rm_rf "#{dist}/assets"
    FileUtils.rm_rf "#{dist_admin}/assets"
    FileUtils.cp_r "#{org}/assets", "#{dist}"
    FileUtils.cp_r "#{org}/assets", "#{dist_admin}"

  else
    puts "unknown arguments: #{ARGV}"

  end
  ARGV.slice(1, ARGV.size).each{|v| task v.to_sym do; end} # hack for natural arguments
end
