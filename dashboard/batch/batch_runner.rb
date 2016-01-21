require 'active_support/core_ext/string'

require './config/initialize'
require "./batch/generator"
require "./batch/convertor"

module Grock
  class BatchRunner
    def self.run(class_name)
      clazz = Module.const_get("Grock::#{class_name.to_s.camelize}")
      
      if ENV['APP_ENV'] == 'development'
        require 'benchmark'
        result = Benchmark.realtime { clazz.new.exec }
        puts "#{ARGV[0]} time: #{result}s"
      else
        clazz.new.exec
      end
    end
  end
end
