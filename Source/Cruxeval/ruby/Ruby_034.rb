def f(nums, odd1, odd2)
    nums.delete(odd1) while nums.include?(odd1)
    nums.delete(odd2) while nums.include?(odd2)
    nums
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([2, 7, 7, 6, 8, 4, 2, 5, 21], candidate.call([1, 2, 3, 7, 7, 6, 8, 4, 1, 2, 3, 5, 1, 3, 21, 1, 3], 3, 1))
  end
end
