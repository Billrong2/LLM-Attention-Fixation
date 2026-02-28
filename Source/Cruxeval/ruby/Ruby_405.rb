def f(xs)
    new_x = xs[0] - 1
    xs.shift
    while new_x <= xs[0] do
        xs.shift
        new_x -= 1
    end
    xs.unshift(new_x)
    xs
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([5, 3, 4, 1, 2, 3, 5], candidate.call([6, 3, 4, 1, 2, 3, 5]))
  end
end
