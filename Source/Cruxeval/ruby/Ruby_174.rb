def f(lst)
    lst[1..3] = lst[1..3].reverse
    lst
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([1, 3, 2], candidate.call([1, 2, 3]))
  end
end
