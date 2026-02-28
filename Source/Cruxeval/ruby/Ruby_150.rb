def f(numbers, index)
  numbers[index..-1].each do |n|
    numbers.insert(index, n)
    index += 1
  end
  numbers[0...index]
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([-2, 4, -4], candidate.call([-2, 4, -4], 0))
  end
end
