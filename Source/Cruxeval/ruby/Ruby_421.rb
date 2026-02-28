def f(s, n)
    if s.length < n
        s
    else
        s[n..-1]
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("try.", candidate.call("try.", 5))
  end
end
