def f(nums, start, k)
  nums[start, k] = nums[start, k].reverse
  nums
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([1, 2, 3, 4, 6, 5], candidate.call([1, 2, 3, 4, 5, 6], 4, 2))
  end
end
