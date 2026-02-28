def f(nums, mos)
    mos.each do |num|
        nums.delete_at(nums.index(num))
    end
    nums.sort!
    mos.each do |num|
        nums << num
    end
    (0..nums.length-2).each do |i|
        if nums[i] > nums[i+1]
            return false
        end
    end
    true
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(false, candidate.call([3, 1, 2, 1, 4, 1], [1]))
  end
end
