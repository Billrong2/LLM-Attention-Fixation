def f(text)
    text.ljust(text.length + 1, "#")
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("the cow goes moo#", candidate.call("the cow goes moo"))
  end
end
