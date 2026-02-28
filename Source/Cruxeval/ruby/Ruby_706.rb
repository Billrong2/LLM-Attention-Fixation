def f(r, w)
    a = []
    if r[0] == w[0] && w[-1] == r[-1]
        a << r
        a << w
    else
        a << w
        a << r
    end
    a
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(["xy", "ab"], candidate.call("ab", "xy"))
  end
end
