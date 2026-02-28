def f(nums, target)
    if nums.count(0) > 0
        return 0
    elsif nums.count(target) < 3
        return 1
    else
        return nums.index(target)
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(1, candidate.call([1, 1, 1, 2], 3))
  end
end
