def f(s)
    s.gsub('(', '[').gsub(')', ']')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("[ac]", candidate.call("(ac)"))
  end
end
