def f(nums, n)
    pos = nums.length - 1
    (-nums.length..-1).each do |i|
        nums.insert(pos, nums[i])
    end
    nums
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([], candidate.call([], 14))
  end
end
