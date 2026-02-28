def f(array)
    new_array = array.reverse
    new_array.map { |x| x*x }
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([1, 4, 1], candidate.call([1, 2, 1]))
  end
end
