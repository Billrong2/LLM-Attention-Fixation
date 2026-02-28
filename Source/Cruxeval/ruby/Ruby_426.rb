def f(numbers, elem, idx)
    if idx > numbers.length
        numbers.push(elem)
    else
        numbers.insert(idx, elem)
    end
    numbers
end

require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([1, 2, 3, 8], candidate.call([1, 2, 3], 8, 5))
  end
end
