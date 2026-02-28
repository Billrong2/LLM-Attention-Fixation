def f(s)
  d = Hash[s.chars.map { |c| [c, 0] }]
  d.keys
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(["1", "2", "a", "b", "3", "x", "y"], candidate.call("12ab23xy"))
  end
end
