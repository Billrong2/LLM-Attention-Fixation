def f(nums, i)
    nums.delete_at(i)
    nums
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([45, 3, 61, 39, 27, 47], candidate.call([35, 45, 3, 61, 39, 27, 47], 0))
  end
end
