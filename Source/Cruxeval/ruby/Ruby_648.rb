def f(list1, list2)
  l = list1.dup
  while l.length > 0
    if list2.include?(l.last)
      l.pop
    else
      return l.last
    end
  end
  return 'missing'
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(6, candidate.call([0, 4, 5, 6], [13, 23, -5, 0]))
  end
end
