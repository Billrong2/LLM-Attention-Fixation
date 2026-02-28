def f(nums)
  (0...nums.length).each do |i|
    if nums[i] % 3 == 0
      nums.push(nums[i])
    end
  end
  nums
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([1, 3, 3], candidate.call([1, 3]))
  end
end
