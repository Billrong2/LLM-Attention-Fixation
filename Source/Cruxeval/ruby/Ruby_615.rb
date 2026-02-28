def f(in_list, num)
    in_list.push(num)
    in_list[0...-1].index(in_list[0...-1].max)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(1, candidate.call([-1, 12, -6, -2], -1))
  end
end
