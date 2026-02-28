def f(array, elem)
    if array.include?(elem)
        return array.index(elem)
    end
    return -1
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(0, candidate.call([6, 2, 7, 1], 6))
  end
end
