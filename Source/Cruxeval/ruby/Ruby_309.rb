def f(text, suffix)
    text += suffix
    while text[-suffix.length..-1] == suffix
        text = text[0..-2]
    end
    text
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("faqo osax ", candidate.call("faqo osax f", "f"))
  end
end
