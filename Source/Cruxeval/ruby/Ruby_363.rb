def f(nums)
    nums.sort!
    n = nums.length
    new_nums = [nums[n/2]]
    
    if n % 2 == 0
        new_nums = [nums[n/2 - 1], nums[n/2]]
    end
    
    (0...n/2).each do |i|
        new_nums.insert(0, nums[n-i-1])
        new_nums << nums[i]
    end
    
    new_nums
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([1], candidate.call([1]))
  end
end
