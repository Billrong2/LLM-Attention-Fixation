def f(nums, p)
    prev_p = p - 1
    prev_p = nums.length - 1 if prev_p < 0
    nums[prev_p]
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(1, candidate.call([6, 8, 2, 5, 3, 1, 9, 7], 6))
  end
end
