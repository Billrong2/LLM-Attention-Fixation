def f(text, n)
    length = text.length
    text[length*(n%4)..length-1]
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("", candidate.call("abc", 1))
  end
end
