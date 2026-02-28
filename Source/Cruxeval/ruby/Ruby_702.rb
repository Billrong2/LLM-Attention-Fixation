def f(nums)
    count = nums.length
    (nums.length - 1).downto(0) do |i|
        nums.insert(i, nums.shift)
    end
    nums
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([-4, -5, 0], candidate.call([0, -5, -4]))
  end
end
