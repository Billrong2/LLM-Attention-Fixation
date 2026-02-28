def f(array, target)
    count, i = 0, 1
    for j in 1..(array.length - 1)
        if (array[j] > array[j-1]) && (array[j] <= target)
            count += i
        elsif array[j] <= array[j-1]
            i = 1
        else
            i += 1
        end
    end
    count
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(1, candidate.call([1, 2, -1, 4], 2))
  end
end
