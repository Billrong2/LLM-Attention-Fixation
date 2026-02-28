def f(s)
    arr = s.strip.chars
    arr.reverse.join
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("POO", candidate.call("   OOP   "))
  end
end
