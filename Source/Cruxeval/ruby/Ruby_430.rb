def f(arr1, arr2)
  new_arr = arr1.dup
  new_arr.concat(arr2)
  new_arr
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([5, 1, 3, 7, 8, "", 0, -1, []], candidate.call([5, 1, 3, 7, 8], ["", 0, -1, []]))
  end
end
