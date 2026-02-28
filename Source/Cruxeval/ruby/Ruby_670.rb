def f(a, b)
  d = a.zip(b).to_h
  a.sort_by { |x| d[x] }.reverse!
  a.map { |x| d.delete(x) }
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([2, 2], candidate.call(["12", "ab"], [2, 2]))
  end
end
