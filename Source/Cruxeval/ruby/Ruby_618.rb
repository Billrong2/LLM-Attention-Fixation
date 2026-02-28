def f(match, fill, n)
    fill[0...n] + match
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("89", candidate.call("9", "8", 2))
  end
end
