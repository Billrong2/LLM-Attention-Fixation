def f(lst, mode)
    result = lst.clone
    if mode != 0
        result.reverse!
    end
    result
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([4, 3, 2, 1], candidate.call([1, 2, 3, 4], 1))
  end
end
