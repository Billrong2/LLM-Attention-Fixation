def f(nums)
    nums[nums.length/2]
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(-5, candidate.call([-1, -3, -5, -7, 0]))
  end
end
