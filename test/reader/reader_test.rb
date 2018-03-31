require "minitest/autorun"
require "minitest/unit"
require "minitest-power_assert"
require "./src/reader/reader"

MiniTest.autorun

class ReaderTest < Minitest::Test
  class Testee < GROCK::Metadata

  end

  def test_read_hash
    expect = {
      "code" => "sample_code",
      "name" => "Sample Code",
    }
    path = "./test/data/sample.yaml"
    result = GROCK::Reader.new.read(Testee, path)

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
    path = "./test/data/sample_list.yaml"
    results = GROCK::Reader.new.read(Testee, path)

    assert { expect == results.map {|r| r.metadata} }
  end
end
