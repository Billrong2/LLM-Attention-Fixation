def f(text)
    length = text.length / 2
    left_half = text[0, length]
    right_half = text[length..-1].reverse
    left_half + right_half
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("n", candidate.call("n"))
  end
end
