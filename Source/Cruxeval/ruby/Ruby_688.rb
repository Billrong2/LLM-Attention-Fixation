def f(nums)
    l = []
    nums.each do |i|
        l << i unless l.include?(i)
    end
    l
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([3, 1, 9, 0, 2, 8], candidate.call([3, 1, 9, 0, 2, 0, 8]))
  end
end
