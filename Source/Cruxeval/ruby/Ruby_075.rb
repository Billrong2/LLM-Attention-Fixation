def f(array, elem)
    ind = array.index(elem)
    return ind * 2 + array[-ind - 1] * 3
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(-22, candidate.call([-1, 2, 1, -8, 2], 2))
  end
end
