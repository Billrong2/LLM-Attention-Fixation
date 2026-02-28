def f(a)
    if a.length >= 2 && a[0] > 0 && a[1] > 0
        a.reverse
        return a
    end
    a << 0
    return a
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([0], candidate.call([]))
  end
end
