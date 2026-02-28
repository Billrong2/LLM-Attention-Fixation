def f(nums, target)
    cnt = nums.count(target)
    cnt * 2
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(4, candidate.call([1, 1], 1))
  end
end
