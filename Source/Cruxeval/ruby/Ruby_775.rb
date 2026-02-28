def f(nums)
    count = nums.length
    (0...count/2).each do |i|
        nums[i], nums[count-i-1] = nums[count-i-1], nums[i]
    end
    nums
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([1, 3, 1, 6, 2], candidate.call([2, 6, 1, 3, 1]))
  end
end
