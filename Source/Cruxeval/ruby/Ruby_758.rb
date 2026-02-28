def f(nums)
    nums.reverse == nums
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(false, candidate.call([0, 3, 6, 2]))
  end
end
