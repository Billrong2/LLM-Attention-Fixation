def f(parts)
  parts.to_h.values
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([-5, 7], candidate.call([["u", 1], ["s", 7], ["u", -5]]))
  end
end
