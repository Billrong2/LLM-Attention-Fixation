def f(nums)
    count = nums.length
    for i in 0..count-1
        nums.insert(i, nums[i]*2)
    end
    nums
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([4, 4, 4, 4, 4, 4, 2, 8, -2, 9, 3, 3], candidate.call([2, 8, -2, 9, 3, 3]))
  end
end
