def f(array, lst)
    array.concat(lst)
    array.select { |e| e % 2 == 0 }
    array.select { |e| e >= 10 }
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([15, 15], candidate.call([2, 15], [15, 1]))
  end
end
