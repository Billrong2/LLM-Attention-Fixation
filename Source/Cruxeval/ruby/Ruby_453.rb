def f(string, c)
    string.end_with?(c)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(false, candidate.call("wrsch)xjmb8", "c"))
  end
end
