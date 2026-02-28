def f(array, index, value)
    array.insert(0, index + 1)
    if value >= 1
        array.insert(index, value)
    end
    array
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([2, 1, 2], candidate.call([2], 0, 2))
  end
end
