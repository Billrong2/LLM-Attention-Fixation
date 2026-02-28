def f(text, character)
    subject = text[text.rindex(character)..]
    return subject * text.count(character)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("", candidate.call("h ,lpvvkohh,u", "i"))
  end
end
