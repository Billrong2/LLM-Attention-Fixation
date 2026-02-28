def f(array)
    return_arr = []
    array.each do |a|
        return_arr << a.dup
    end
    return_arr
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([[1, 2, 3], [], [1, 2, 3]], candidate.call([[1, 2, 3], [], [1, 2, 3]]))
  end
end
