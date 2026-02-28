def f(nums)
    nums = nums.dup
    count = nums.length
    (-count+1...0).each do |i|
        nums.insert(0, nums[i])
    end
    nums
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([2, 0, 6, 2, 1, 7, 1, 2, 6, 0, 2], candidate.call([7, 1, 2, 6, 0, 2]))
  end
end
