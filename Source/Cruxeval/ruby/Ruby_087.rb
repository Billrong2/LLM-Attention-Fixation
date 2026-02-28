def f(nums)
    nums.reverse!
    nums.map(&:to_s).join('')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("-2139-1", candidate.call([-1, 9, 3, 1, -2]))
  end
end
