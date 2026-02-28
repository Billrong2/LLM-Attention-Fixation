def f(nums, pos)
    s = nil
    if pos % 2 != 0
        s = 0...-1
    end
    nums[s] = nums[s].reverse
    nums
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([6, 1], candidate.call([6, 1], 3))
  end
end
