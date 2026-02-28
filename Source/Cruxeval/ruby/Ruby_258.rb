def f(l, m, start, step)
  l.insert(start, m)
  (start-1).step(1, -step).each do |x|
    l.insert(x, l.delete_at(l.rindex(m)-1)) if l.rindex(m)
  end
  l
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([1, 2, 7, 3, 9], candidate.call([1, 2, 7, 9], 3, 3, 2))
  end
end
