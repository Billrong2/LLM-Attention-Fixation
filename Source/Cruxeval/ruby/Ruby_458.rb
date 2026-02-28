def f(text, search_chars, replace_chars)
    trans_table = Hash[search_chars.split('').zip(replace_chars.split(''))]
    text.tr(trans_table.keys.join, trans_table.values.join)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("pppo4pIp", candidate.call("mmm34mIm", "mm3", ",po"))
  end
end
