def f(a, b, c, d)
  a && b || c && d
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("BFS", candidate.call("CJU", "BFS", "WBYDZPVES", "Y"))
  end
end
