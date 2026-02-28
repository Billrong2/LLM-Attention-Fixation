def f(single_digit)
    result = []
    (1..10).each do |c|
        result << c unless c == single_digit
    end
    result
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([1, 2, 3, 4, 6, 7, 8, 9, 10], candidate.call(5))
  end
end
