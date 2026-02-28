def f(text, speaker)
    while text.start_with?(speaker)
        text = text[speaker.length..-1]
    end
    text
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("Do you know who the other was? [NEGMENDS]", candidate.call("[CHARRUNNERS]Do you know who the other was? [NEGMENDS]", "[CHARRUNNERS]"))
  end
end
