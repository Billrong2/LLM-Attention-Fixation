def f(array, ind, elem)
    index = ind < 0 ? -5 : ind > array.length ? array.length : ind + 1
    array.insert(index, elem)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([1, 5, 8, 7, 2, 0, 3], candidate.call([1, 5, 8, 2, 0, 3], 2, 7))
  end
end
