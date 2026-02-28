def f(text)
    text.delete(')')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("(((((((((((d.(((((", candidate.call("(((((((((((d))))))))).))))((((("))
  end
end
