def f(text, n)
    if text.length <= 2
        text
    else
        leading_chars = text[0] * (n - text.length + 1)
        leading_chars + text[1..-2] + text[-1]
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("g", candidate.call("g", 15))
  end
end
