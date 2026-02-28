def f(array, i_num, elem)
    array.insert(i_num, elem)
    return array
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([-4, 4, 1, 0], candidate.call([-4, 1, 0], 1, 4))
  end
end
