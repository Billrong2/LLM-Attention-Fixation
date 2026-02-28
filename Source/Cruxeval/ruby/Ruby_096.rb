def f(text)
  text.chars.none? { |c| c == c.upcase }
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(true, candidate.call("lunabotics"))
  end
end
