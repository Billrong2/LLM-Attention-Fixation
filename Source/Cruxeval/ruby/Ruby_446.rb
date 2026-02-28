def f(array)
    l = array.length
    if l % 2 == 0
        array.clear
    else
        array.reverse
    end
    array
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([], candidate.call([]))
  end
end
