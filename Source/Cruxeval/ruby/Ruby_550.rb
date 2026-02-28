def f(nums)
  (0...nums.length).each do |i|
    nums.insert(i, nums[i]**2)
  end
  nums
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([1, 1, 1, 1, 2, 4], candidate.call([1, 2, 4]))
  end
end
