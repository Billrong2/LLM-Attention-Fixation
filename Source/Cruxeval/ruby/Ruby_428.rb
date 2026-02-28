def f(nums)
    nums.each_with_index do |num, i|
        if i.even?
            nums << nums[i] * nums[i + 1]
        end
    end
    nums
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([], candidate.call([]))
  end
end
