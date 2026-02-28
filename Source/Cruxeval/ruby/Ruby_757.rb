def f(text, char, replace)
    text.gsub(char, replace)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("an2a8", candidate.call("a1a8", "1", "n2"))
  end
end
