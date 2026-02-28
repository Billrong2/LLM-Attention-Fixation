def f(text, char)
    text.rindex(char)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(2, candidate.call("breakfast", "e"))
  end
end
