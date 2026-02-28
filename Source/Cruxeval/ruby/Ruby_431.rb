def f(n, m)
    arr = (1..n).to_a
    m.times do
        arr.clear
    end
    arr
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([], candidate.call(1, 3))
  end
end
