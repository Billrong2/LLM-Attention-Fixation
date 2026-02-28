def f(nums, sort_count)
    nums.sort
    nums.take(sort_count)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([1], candidate.call([1, 2, 2, 3, 4, 5], 1))
  end
end
