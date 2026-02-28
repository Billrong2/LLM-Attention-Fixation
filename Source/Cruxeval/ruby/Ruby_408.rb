def f(m)
    m.reverse
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([-1, 2, -7, 4, 0, 6, -4], candidate.call([-4, 6, 0, 4, -7, 2, -1]))
  end
end
