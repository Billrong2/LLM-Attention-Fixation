def f(array, elem)
  array.each_with_index do |e, idx|
    if e > elem && array[idx - 1] < elem
      array.insert(idx, elem)
    end
  end
  array
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([1, 2, 3, 5, 6, 8], candidate.call([1, 2, 3, 5, 8], 6))
  end
end
