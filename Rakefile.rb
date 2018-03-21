require "./musiki/musiki"

task :all => [:build, :gen]

task :build do
  system "bundle exec sass -r sass-css-importer musiki/styles/style.scss musiki/assets/style1.css"
end

task :gen do
  Musiki.gen
end

task :band do
  puts ARGV
  Musiki.band ARGV[1..-1].join(" ")
  ARGV.slice(1, ARGV.size).each{|v| task v.to_sym do; end} # hack for natural arguments
end

task :down do
  puts ARGV[1..-1].join(" ")
  puts ARGV[1..-1].join(" ").downcase.gsub(" ", "_")
  ARGV.slice(1, ARGV.size).each{|v| task v.to_sym do; end} # hack for natural arguments
end
