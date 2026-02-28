def f(nums)
    count = nums.length / 2
    count.times { nums.shift }
    nums
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([1, 2, 3], candidate.call([3, 4, 1, 2, 3]))
  end
end
