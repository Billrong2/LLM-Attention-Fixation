def f(li)
    li.map { |i| li.count(i) }
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([1, 3, 1, 3, 3, 1, 1, 1, 1, 1, 1], candidate.call(["k", "x", "c", "x", "x", "b", "l", "f", "r", "n", "g"]))
  end
end
