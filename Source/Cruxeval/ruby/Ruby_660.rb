def f(num)
    initial = [1]
    total = initial
    num.times do
        total = [1] + total.each_cons(2).map { |x, y| x + y }
        initial << total[-1]
    end
    initial.sum
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(4, candidate.call(3))
  end
end
