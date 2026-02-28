def f(nums, pos, value)
    nums.insert(pos, value)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([3, 1, 0, 2], candidate.call([3, 1, 2], 2, 0))
  end
end
