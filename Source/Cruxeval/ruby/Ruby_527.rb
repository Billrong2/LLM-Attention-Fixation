def f(text, value)
    text.ljust(value.length, "?")
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("!?", candidate.call("!?", ""))
  end
end
