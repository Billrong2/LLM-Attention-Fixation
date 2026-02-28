def f(nums)
  (nums.length - 1).downto(0) do |i|
    if nums[i] % 2 == 1
      nums.insert(i + 1, nums[i])
    end
  end
  nums
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([2, 3, 3, 4, 6, -2], candidate.call([2, 3, 4, 6, -2]))
  end
end
