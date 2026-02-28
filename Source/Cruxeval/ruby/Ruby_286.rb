def f(array, x, i)
    if i < -array.length || i > array.length - 1
        'no'
    else
        temp = array[i]
        array[i] = x
        array
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([1, 2, 3, 4, 11, 6, 7, 8, 9, 10], candidate.call([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 11, 4))
  end
end
