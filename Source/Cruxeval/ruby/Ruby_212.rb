def f(nums)
  (nums.length - 1).times do
    nums.reverse!
  end
  nums
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([1, -9, 7, 2, 6, -3, 3], candidate.call([1, -9, 7, 2, 6, -3, 3]))
  end
end
