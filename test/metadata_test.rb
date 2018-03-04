require "minitest/autorun"
require "minitest/unit"
require "minitest-power_assert"
require "./musiki/metadata"

MiniTest.autorun

class MetadataTest < Minitest::Test
  def test_get_not_exist_key
    m = Metadata.new
    assert { m[:not_exist] == nil }
  end

  def test_set
    assert_metadata = Proc.new {|key, value, expect|
      m = Metadata.new
      m[key] = value
      assert { m[key] == expect }
      m = Metadata.new
      m[key.to_s] = value
      assert { m[key.to_s] == expect }
    }
    assert_metadata.call :key, "hoge", "hoge"
    assert_metadata.call :key, ["hoge"], ["hoge"]
    assert_metadata.call :key, ["hoge1", "hoge2"], ["hoge1", "hoge2"]
    assert_metadata.call :key, nil, nil
    assert_metadata.call :keys, "hoge", ["hoge"]
    assert_metadata.call :keys, ["hoge"], ["hoge"]
    assert_metadata.call :keys, ["hoge1", "hoge2"], ["hoge1", "hoge2"]
    assert_metadata.call :keys, nil, nil
  end

  def test_add
    assert_metadata = Proc.new {|key, init, value, expect|
      m = Metadata.new
      m[key] = init.nil? ? nil : init.clone
      m.add(key, value)
      assert { m[key] == expect }
      m = Metadata.new
      m[key.to_s] = init.nil? ? nil : init.clone
      m.add(key.to_s, value)
      assert { m[key.to_s] == expect }
    }
    assert_metadata.call :key, "hoge", "hoge", "hoge"
    assert_metadata.call :key, "hoge", ["hoge"], ["hoge"]
    assert_metadata.call :key, "hoge", ["hoge1", "hoge2"], ["hoge1", "hoge2"]
    assert_metadata.call :key, "hoge", nil, nil
    assert_metadata.call :key, nil, "hoge", "hoge"
    assert_metadata.call :key, nil, ["hoge"], ["hoge"]
    assert_metadata.call :key, nil, ["hoge1", "hoge2"], ["hoge1", "hoge2"]
    assert_metadata.call :key, nil, nil, nil
    assert_metadata.call :keys, ["hoge1"], "hoge2", ["hoge1", "hoge2"]
    assert_metadata.call :keys, ["hoge1"], ["hoge2"], ["hoge1", "hoge2"]
    assert_metadata.call :keys, ["hoge1"], ["hoge2", "hoge3"], ["hoge1", "hoge2", "hoge3"]
    assert_metadata.call :keys, ["hoge1"], nil, ["hoge1"]
    assert_metadata.call :keys, nil, "hoge2", ["hoge2"]
    assert_metadata.call :keys, nil, ["hoge2"], ["hoge2"]
    assert_metadata.call :keys, nil, ["hoge2", "hoge3"], ["hoge2", "hoge3"]
    assert_metadata.call :keys, nil, nil, nil
  end
end
