def f(nums)
    count = nums.length
    if count == 0
        nums = [0] * nums.pop.to_i
    elsif count.even?
        nums.clear
    else
        nums.slice!(0, count/2)
    end
    nums
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([], candidate.call([-6, -2, 1, -3, 0, 1]))
  end
end
