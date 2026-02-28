def f(numbers)
    new_numbers = []
    numbers.each_with_index do |_, i|
        new_numbers << numbers[numbers.length - 1 - i]
    end
    new_numbers
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([3, 11], candidate.call([11, 3]))
  end
end
