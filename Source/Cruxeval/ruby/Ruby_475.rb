def f(array, index)
    if index < 0
        index = array.length + index
    end
    array[index]
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(1, candidate.call([1], 0))
  end
end
