def f(lst)
    lst.sort.take(3)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([0, 1, 3], candidate.call([5, 8, 1, 3, 0]))
  end
end
