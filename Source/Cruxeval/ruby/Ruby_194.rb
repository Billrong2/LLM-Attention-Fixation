def f(matr, insert_loc)
    matr.insert(insert_loc, [])
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([[], [5, 6, 2, 3], [1, 9, 5, 6]], candidate.call([[5, 6, 2, 3], [1, 9, 5, 6]], 0))
  end
end
