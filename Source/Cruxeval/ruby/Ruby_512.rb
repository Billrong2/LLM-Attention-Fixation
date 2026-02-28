def f(s)
    s.length == s.count('0') + s.count('1')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(false, candidate.call("102"))
  end
end
