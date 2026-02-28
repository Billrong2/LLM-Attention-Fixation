def f(array)
    n = array.pop
    array.concat([n, n])
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([1, 1, 2, 2, 2], candidate.call([1, 1, 2, 2]))
  end
end
