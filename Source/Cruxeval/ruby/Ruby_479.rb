def f(nums, pop1, pop2)
    nums.delete_at(pop1 - 1)
    nums.delete_at(pop2 - 1)
    return nums
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([1, 2, 3], candidate.call([1, 5, 2, 3, 6], 2, 4))
  end
end
