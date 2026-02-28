def f(lst)
    lst.reverse!
    lst.pop
    lst.reverse!
    lst
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([8, 2, 8], candidate.call([7, 8, 2, 8]))
  end
end
