require "rake/testtask"

Rake::TestTask.new do |t|
  t.pattern = "binder-rack/test/**/*_test.rb"
end
