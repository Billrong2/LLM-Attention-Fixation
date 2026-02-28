def f(text, ch)
    text.count(ch)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(5, candidate.call("This be Pirate's Speak for 'help'!", " "))
  end
end
