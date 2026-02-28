def f(nums)
    nums.clear
    nums.map! { |num| num * 2 }
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([], candidate.call([4, 3, 2, 1, 2, -1, 4, 2]))
  end
end
