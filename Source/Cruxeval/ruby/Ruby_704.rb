def f(s, n, c)
    width = c.length * n
    while s.length < width
        s = c + s
    end
    s
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(".", candidate.call(".", 0, "99"))
  end
end
