require "./binder-rack/core/rakefile"
require "./binder-rack/grock/grock"

task :hoge do
  # p GROCK::Label.new({"name" => nil}).name

  GROCK::GROCK.new.read
end
