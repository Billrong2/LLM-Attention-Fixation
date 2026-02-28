def f(numbers, num, val)
    while numbers.length < num
        numbers.insert(numbers.length / 2, val)
    end
    (numbers.length / (num - 1) - 4).times do
        numbers.insert(numbers.length / 2, val)
    end
    numbers.join(' ')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("", candidate.call([], 0, 1))
  end
end
