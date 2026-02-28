def f(nums)
    count = nums.length
    (-count+1...0).each do |i|
        nums.concat([nums[i], nums[i]])
    end
    nums
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([0, 6, 2, -1, -2, 6, 6, -2, -2, -2, -2, -2, -2], candidate.call([0, 6, 2, -1, -2]))
  end
end
