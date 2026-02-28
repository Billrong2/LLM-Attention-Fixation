def f(array, elem)
  k = 0
  l = array.dup
  l.each do |i|
    if i > elem
      array.insert(k, elem)
      break
    end
    k += 1
  end
  array
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([3, 5, 4, 3, 2, 1, 0], candidate.call([5, 4, 3, 2, 1, 0], 3))
  end
end
