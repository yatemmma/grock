require "minitest/autorun"
require "minitest/unit"
require "minitest-power_assert"
require "./src/data/writer"

MiniTest.autorun

class ReaderTest < Minitest::Test
  class Testee < GROCK::Metadata

  end

  def test_write_hash
    expect = {
      "code" => "sample_code",
      "name" => "Sample Code",
    }
    path = "./test/data/write_sample.yaml"
    GROCK::Writer.new.write_item(Testee.new(expect), path)
    result = GROCK::Reader.new.read_item(Testee, path)

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
    path = "./test/data/write_sample_list.yaml"
    GROCK::Writer.new.write_items([Testee.new(expect1), Testee.new(expect2)], path)
    results = GROCK::Reader.new.read_items(Testee, path)

    assert { [expect1, expect2] == results.map {|r| r.metadata} }
  end
end
