def f(nums, elements)
  result = []
  elements.length.times do
    result << nums.pop
  end
  nums
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([7, 1, 2], candidate.call([7, 1, 2, 6, 0, 2], [9, 0, 3]))
  end
end
