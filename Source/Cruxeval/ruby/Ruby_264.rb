def f(test_str)
    s = test_str.gsub('a', 'A')
    s.gsub('e', 'A')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("pApArA", candidate.call("papera"))
  end
end
