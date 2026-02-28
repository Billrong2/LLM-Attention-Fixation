def f(array, elem)
  array.concat(elem)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([[1, 2, 3], [1, 2], 1, [1, 2, 3], 3, [2, 1]], candidate.call([[1, 2, 3], [1, 2], 1], [[1, 2, 3], 3, [2, 1]]))
  end
end
