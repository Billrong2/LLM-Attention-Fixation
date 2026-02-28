def f(a)
    b = a.dup
    (0..a.length-2).step(2) do |k|
        b.insert(k + 1, b[k])
    end
    b << b[0]
    b
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([5, 5, 5, 5, 5, 5, 6, 4, 9, 5], candidate.call([5, 5, 5, 6, 4, 9]))
  end
end
