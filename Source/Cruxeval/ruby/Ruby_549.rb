def f(matrix)
    matrix.reverse
    result = []
    matrix.each do |primary|
        primary.max
        primary.sort.reverse
        result << primary
    end
    result
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([[1, 1, 1, 1]], candidate.call([[1, 1, 1, 1]]))
  end
end
