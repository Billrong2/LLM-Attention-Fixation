def f(nums)
    nums.reverse
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([1, 0, -3, 1, -2, -6], candidate.call([-6, -2, 1, -3, 0, 1]))
  end
end
