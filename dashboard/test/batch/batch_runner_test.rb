require './test/test_helper'
require './batch/batch_runner'

class Dummy
  def exec
    "xxx"
  end
end

module Grock
  class BatchRunnerTest < Minitest::Test
    def test_run
      assert { "xxx" == BatchRunner.run(:dummy) }
    end
  end
end
