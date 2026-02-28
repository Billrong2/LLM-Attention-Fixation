def f(s, amount)
  'z' * (amount - s.length) + s
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("zzzzzabc", candidate.call("abc", 8))
  end
end
