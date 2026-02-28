def f(nums, index)
    nums[index] % 42 + nums.delete_at(index) * 2
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(9, candidate.call([3, 2, 0, 3, 7], 3))
  end
end
