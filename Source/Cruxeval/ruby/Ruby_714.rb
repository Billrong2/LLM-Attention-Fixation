def f(array)
    array.reverse!
    array.clear
    array.concat(['x'] * array.length)
    array.reverse!
    return array
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([], candidate.call([3, -2, 0]))
  end
end
