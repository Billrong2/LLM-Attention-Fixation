def f(s)
    s.chars.map(&:downcase).join
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("abcdefghij", candidate.call("abcDEFGhIJ"))
  end
end
