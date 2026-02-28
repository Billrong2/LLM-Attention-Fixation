def f(nums)
    (nums.length - 2).step(0, -3) do |i|
        if nums[i] == 0
            nums.clear
            return false
        end
    end
    nums
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(false, candidate.call([0, 0, 1, 2, 1]))
  end
end
