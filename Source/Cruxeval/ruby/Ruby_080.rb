def f(s)
    s.rstrip.reverse
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("ba", candidate.call("ab        "))
  end
end
