def f(n)
    b = n.to_s.split('')
    (2..b.length-1).each do |i|
        b[i] += '+'
    end
    return b
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(["4", "4"], candidate.call(44))
  end
end
