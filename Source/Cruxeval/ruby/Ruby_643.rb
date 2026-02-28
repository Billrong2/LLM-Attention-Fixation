def f(text, suffix)
    if text.end_with?(suffix)
        text = text[0...-1] + text[-1].swapcase
    end
    text
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("damdrodM", candidate.call("damdrodm", "m"))
  end
end
