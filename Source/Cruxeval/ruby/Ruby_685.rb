def f(array, elem)
    array.count(elem) + elem
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(-2, candidate.call([1, 1, 1], -2))
  end
end
