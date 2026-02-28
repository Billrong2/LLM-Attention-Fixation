def f(nums)
  output = []
  nums.each do |n|
    output.append([nums.count(n), n])
  end
  output.sort.reverse
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([[4, 1], [4, 1], [4, 1], [4, 1], [2, 3], [2, 3]], candidate.call([1, 1, 3, 1, 3, 1]))
  end
end
