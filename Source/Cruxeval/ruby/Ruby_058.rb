def f(nums)
    count = nums.length
    count.times do |i|
        nums << nums[i % 2]
    end
    nums
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([-1, 0, 0, 1, 1, -1, 0, -1, 0, -1], candidate.call([-1, 0, 0, 1, 1]))
  end
end
