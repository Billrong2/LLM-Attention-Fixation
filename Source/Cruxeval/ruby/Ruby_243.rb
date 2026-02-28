def f(text, char)
  char.downcase == char && text.downcase == text
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(true, candidate.call("abc", "e"))
  end
end
