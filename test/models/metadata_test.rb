require "minitest/autorun"
require "minitest/unit"
require "minitest-power_assert"
require "./src/models/models"

MiniTest.autorun

class ReaderTest < Minitest::Test
  class Testee1 < GROCK::Metadata
    prop :prop1
    prop :prop2, Array
  end

  class Testee2 < GROCK::Metadata
    prop :prop3
  end

  class Testee3 < GROCK::Metadata
  end

  def test_prop
    assert { [:prop1, :prop2] == Testee1.props }
    assert { [:prop3] == Testee2.props }
    assert { [] == Testee3.props }

    assert { String == Testee1.prop_type(:prop1) }
    assert { Array == Testee1.prop_type(:prop2) }
  end
end
