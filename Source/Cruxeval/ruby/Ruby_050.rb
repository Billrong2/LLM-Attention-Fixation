def f(lst)
    lst.clear
    lst += [1] * (lst.length + 1)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([1], candidate.call(["a", "c", "v"]))
  end
end
