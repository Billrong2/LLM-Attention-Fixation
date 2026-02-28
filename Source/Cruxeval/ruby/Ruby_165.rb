def f(text, lower, upper)
    text[lower...upper].ascii_only?
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(true, candidate.call("=xtanp|sugv?z", 3, 6))
  end
end
