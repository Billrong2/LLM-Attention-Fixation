def f(text, strip_chars)
    text.reverse.sub(Regexp.new("^[#{strip_chars}]*|[#{strip_chars}]*$"), '').reverse
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("tcmfsm", candidate.call("tcmfsmj", "cfj"))
  end
end
