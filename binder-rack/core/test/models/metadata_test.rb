require "minitest/autorun"
require "minitest/unit"
require "minitest-power_assert"
require_relative "../../models/metadata"

MiniTest.autorun

class ContentsTest < Minitest::Test
  class Testee1 < BinderRack::Core::Metadata
    prop :prop1
    prop :prop2, Array
  end

  class Testee2 < BinderRack::Core::Metadata
    prop :prop3
  end

  class Testee3 < BinderRack::Core::Metadata
  end

  def test_prop
    assert { [:prop1, :prop2] == Testee1.props }
    assert { [:prop3] == Testee2.props }
    assert { [] == Testee3.props }

    assert { String == Testee1.prop_type(:prop1) }
    assert { Array == Testee1.prop_type(:prop2) }
  end

  def test_new
    data = {
      "prop1" => "val1",
      "prop2" => "val2"
    }

    # testee = Testee1.new(data)
    # assert { "val1" == testee.prop1 }
    # assert { ["val2"] == testee.prop2 }

  end
end
