def f(nums)
    count = nums.length
    while nums.length > count/2
        nums.clear
    end
    nums
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([], candidate.call([2, 1, 2, 3, 1, 6, 3, 8]))
  end
end
