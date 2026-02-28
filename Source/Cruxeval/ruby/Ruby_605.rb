def f(nums)
    nums.clear
    "quack"
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("quack", candidate.call([2, 5, 1, 7, 9, 3]))
  end
end
