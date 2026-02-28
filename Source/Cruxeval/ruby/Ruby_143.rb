def f(s, n)
    s.downcase == n.downcase
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(true, candidate.call("daaX", "daaX"))
  end
end
