def f(text)
    text.index(",")
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(9, candidate.call("There are, no, commas, in this text"))
  end
end
