def f(x)
    n = x.length
    i = 0
    while i < n && x[i].match?(/\d/)
        i += 1
    end
    i == n
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(true, candidate.call("1"))
  end
end
