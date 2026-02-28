def f(text, char)
    text.split(char, -1).join(' ')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(" ", candidate.call("a", "a"))
  end
end
