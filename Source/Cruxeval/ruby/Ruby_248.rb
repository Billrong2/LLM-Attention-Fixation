def f(a, b)
    a.sort()
    b.sort.reverse
    a + b
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([666], candidate.call([666], []))
  end
end
