def f(lst, i, n)
    lst.insert(i, n)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([44, 34, 23, 82, 15, 24, 11, 63, 99], candidate.call([44, 34, 23, 82, 24, 11, 63, 99], 4, 15))
  end
end
