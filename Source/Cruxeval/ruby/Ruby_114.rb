def f(text, sep)
  text.split(sep, -2)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(["a", "", "b"], candidate.call("a-.-.b", "-."))
  end
end
