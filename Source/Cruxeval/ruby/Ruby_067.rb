def f(num1, num2, num3)
    nums = [num1, num2, num3]
    nums.sort!
    "#{nums[0]},#{nums[1]},#{nums[2]}"
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("6,8,8", candidate.call(6, 8, 8))
  end
end
