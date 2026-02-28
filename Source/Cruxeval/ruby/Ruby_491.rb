def f(xs)
  for i in -1.downto(-xs.length)
    xs.concat([xs[i], xs[i]])
  end
  xs
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([4, 8, 8, 5, 5, 5, 5, 5, 5, 5, 5, 5], candidate.call([4, 8, 8, 5]))
  end
end
