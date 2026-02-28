def f(array, l)
    if l <= 0
        array
    elsif array.length < l
        array.concat(f(array, l - array.length))
    else
        array
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([1, 2, 3, 1, 2, 3], candidate.call([1, 2, 3], 4))
  end
end
