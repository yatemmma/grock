require "minitest/autorun"
require "minitest/unit"
require "minitest-power_assert"
require_relative "../../data/reader"
require_relative "../../models/metadata"

MiniTest.autorun

class ReaderTest < Minitest::Test
  class Testee < BinderRack::Core::Metadata
    
  end

  def test_read_hash
    expect = {
      "code" => "sample_code",
      "name" => "Sample Code",
    }
    path = "#{File.dirname(__FILE__)}/sample.yaml"
    result = BinderRack::Core::Reader.new.read_item(Testee, path)

    assert { expect == result.metadata }
  end

  def test_read_array
    expect = [
      {
        "code" => "sample_code1",
        "name" => "Sample Code 1",
      },
      {
        "code" => "sample_code2",
        "name" => "Sample Code 2",
      }
    ]
    path = "#{File.dirname(__FILE__)}/sample_list.yaml"
    results = BinderRack::Core::Reader.new.read_items(Testee, path)

    assert { expect == results.map {|r| r.metadata} }
  end
end
