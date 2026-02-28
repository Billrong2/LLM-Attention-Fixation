def f(nums)
    a = 0
    nums.length.times do |i|
        nums.insert(i, nums[a])
        a += 1
    end
    nums
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([1, 1, 1, 1, 1, 1, 1, 3, -1, 1, -2, 6], candidate.call([1, 3, -1, 1, -2, 6]))
  end
end
