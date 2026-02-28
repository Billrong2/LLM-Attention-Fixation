def f(nums, n)
    nums.delete_at(n)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(4, candidate.call([-7, 3, 1, -1, -1, 0, 4], 6))
  end
end
