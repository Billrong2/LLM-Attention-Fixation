def f(text, delim)
  text[0...text.reverse.index(delim)].reverse
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("d", candidate.call("dsj osq wi w", " "))
  end
end
