def f(nums)
  nums.reverse_each.with_index do |num, i|
    nums.delete_at(i) if num.even?
  end
  nums
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([5, 3, 3, 7], candidate.call([5, 3, 3, 7]))
  end
end
