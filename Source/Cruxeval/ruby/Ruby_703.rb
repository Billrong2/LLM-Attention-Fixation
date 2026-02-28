def f(text, char)
    count = text.scan(char * 2).count
    return text[count..-1]
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("zzv2sg", candidate.call("vzzv2sg", "z"))
  end
end
