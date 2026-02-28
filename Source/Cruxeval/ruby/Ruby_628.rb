def f(nums, delete)
    nums.delete(delete)
    nums
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([4, 3, 6, 1], candidate.call([4, 5, 3, 6, 1], 5))
  end
end
