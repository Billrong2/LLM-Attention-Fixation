def f(array, n)
    array[n..-1]
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([2, 2, 2], candidate.call([0, 0, 1, 2, 2, 2, 2], 4))
  end
end
