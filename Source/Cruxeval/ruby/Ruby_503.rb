def f(d)
  result = Array.new(d.length)
  a = b = 0
  until d.empty?
    result[a] = d.shift(a == b)
    a, b = b, (b+1) % result.length
  end
  result
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([], candidate.call({}))
  end
end
