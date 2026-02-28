def f(k, j)
  arr = []
  k.times do
    arr << j
  end
  arr
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([5, 5, 5, 5, 5, 5, 5], candidate.call(7, 5))
  end
end
