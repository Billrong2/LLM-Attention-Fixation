def f(nums)
    nums = nums.select { |y| y > 0 }
    if nums.length <= 3
        return nums
    end
    nums.reverse!
    half = nums.length/2
    return nums[0...half] + [0]*5 + nums[half..-1]
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([6, 2, 0, 0, 0, 0, 0, 2, 3, 10], candidate.call([10, 3, 2, 2, 6, 0]))
  end
end
