def f(text, value)
    return '' unless text.include?(value)
    text.rpartition(value)[0]
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("mmfb", candidate.call("mmfbifen", "i"))
  end
end
