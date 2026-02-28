def f(nums, number)
    nums.count(number)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(2, candidate.call([12, 0, 13, 4, 12], 12))
  end
end
