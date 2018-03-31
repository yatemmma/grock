require "rake/testtask"

Rake::TestTask.new do |t|
  t.pattern = "#{File.dirname(__FILE__)}/test/**/*_test.rb"
end
