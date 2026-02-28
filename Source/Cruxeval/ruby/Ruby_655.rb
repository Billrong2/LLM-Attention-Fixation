def f(s)
    s.gsub('a', '').gsub('r', '')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("p", candidate.call("rpaar"))
  end
end
