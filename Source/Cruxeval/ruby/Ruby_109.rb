def f(nums, spot, idx)
    nums.insert(spot, idx)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([9, 1, 0, 1, 1], candidate.call([1, 0, 1, 1], 0, 9))
  end
end
