require "minitest/autorun"
require "minitest/unit"
require "minitest-power_assert"
require "./binder-rack/core/data/writer"

MiniTest.autorun

class WriterTest < Minitest::Test
  class Testee < BinderRack::Core::Metadata

  end

  def test_write_hash
    expect = {
      "code" => "sample_code",
      "name" => "Sample Code",
    }
    path = "./binder-rack/test/data/write_sample.yaml"
    BinderRack::Core::Writer.new.write_item(Testee.new(expect), path)
    result = BinderRack::Core::Reader.new.read_item(Testee, path)

    assert { expect == result.metadata }
  end

  def test_write_array
    expect1 = {
      "code" => "sample_code1",
      "name" => "Sample Code 1",
    }
    expect2 = {
      "code" => "sample_code2",
      "name" => "Sample Code 2",
    }
    path = "./binder-rack/test/data/write_sample_list.yaml"
    BinderRack::Core::Writer.new.write_items([Testee.new(expect1), Testee.new(expect2)], path)
    results = BinderRack::Core::Reader.new.read_items(Testee, path)

    assert { [expect1, expect2] == results.map {|r| r.metadata} }
  end
end
