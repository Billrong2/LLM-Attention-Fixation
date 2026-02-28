def f(nums)
    asc = nums.dup
    desc = []
    asc.reverse
    desc = asc[0...asc.length/2]
    desc + asc + desc
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([], candidate.call([]))
  end
end
