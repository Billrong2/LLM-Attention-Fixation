def f(array, num)
    reverse = false
    if num < 0
        reverse = true
        num *= -1
    end
    array = array.reverse * num
    l = array.length
    
    if reverse
        array = array.reverse
    end
    array
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([2, 1], candidate.call([1, 2], 1))
  end
end
