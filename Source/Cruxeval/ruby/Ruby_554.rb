def f(arr)
    arr.reverse
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([-5, 3, 9999, 1, 0, 2], candidate.call([2, 0, 1, 9999, 3, -5]))
  end
end
