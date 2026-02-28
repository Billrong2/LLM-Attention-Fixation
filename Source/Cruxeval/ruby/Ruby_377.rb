def f(text)
  text.split("\n").join(", ")
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("BYE, NO, WAY", candidate.call("BYE
NO
WAY"))
  end
end
