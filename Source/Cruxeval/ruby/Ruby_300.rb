def f(nums)
    count = 1
    nums.each_index do |i|
        if i >= count && i < nums.length - 1 && i % 2 == 0
            nums[i] = [nums[i], nums[count-1]].max
            count += 1
        end
    end
    nums
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([1, 2, 3], candidate.call([1, 2, 3]))
  end
end
