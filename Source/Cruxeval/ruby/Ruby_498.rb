def f(nums, idx, added)
    nums.insert(idx, added)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([2, 2, 3, 2, 3, 3], candidate.call([2, 2, 2, 3, 3], 2, 3))
  end
end
