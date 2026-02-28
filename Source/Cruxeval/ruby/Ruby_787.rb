def f(text)
    return '' if text.length == 0
    text = text.downcase
    text[0] = text[0].upcase
    text
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("Xzd", candidate.call("xzd"))
  end
end
