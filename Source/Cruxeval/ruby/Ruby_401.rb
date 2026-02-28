def f(text, suffix)
    if suffix && text.end_with?(suffix)
        text[0...-suffix.length]
    else
        text
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("mathematics", candidate.call("mathematics", "example"))
  end
end
