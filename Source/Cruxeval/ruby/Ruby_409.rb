def f(text, char)
    if text
        text = text.delete_prefix(char)
        text = text.delete_prefix(text[-1])
        text = text[0...-1] + text[-1].capitalize
    end
    text
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("querisT", candidate.call("querist", "u"))
  end
end
