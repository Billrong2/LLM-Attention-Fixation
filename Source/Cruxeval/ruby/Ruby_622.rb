def f(s)
    left, sep, right = s.rpartition('.')
    new = [right, left].join(sep)
    _, sep, _ = new.rpartition('.')
    new.gsub(sep, ', ')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(", g, a, l, g, u, ", candidate.call("galgu"))
  end
end
