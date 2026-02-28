def f(array, elem)
    array.reverse!
    found = array.index(elem)
    array.reverse!
    found
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(0, candidate.call([5, -3, 3, 2], 2))
  end
end
