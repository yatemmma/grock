require './test/test_helper'
require './batch/generator'

module Grock
  class GeneratorTest < Minitest::Test
    def test_exec
      assert { 1 == Generator.new.exec }
    end
  end
end
