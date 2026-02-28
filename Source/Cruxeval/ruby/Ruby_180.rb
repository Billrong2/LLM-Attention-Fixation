def f(nums)
    a = -1
    b = nums[1..-1]
    while a <= b[0] do
        nums.delete(b[0])
        a = 0
        b = b[1..-1]
    end
    nums
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([-1, -2, -6, 8, 8], candidate.call([-1, 5, 3, -2, -6, 8, 8]))
  end
end
