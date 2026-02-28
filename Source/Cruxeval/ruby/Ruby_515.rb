def f(array)
    result = array.reverse.map { |item| item * 2 }
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([10, 8, 6, 4, 2], candidate.call([1, 2, 3, 4, 5]))
  end
end
