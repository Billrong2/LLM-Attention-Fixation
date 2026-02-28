require 'set'

def f(n)
    values = {0 => 3, 1 => 4.5, 2 => '-'}
    res = {}
    values.each do |i, j|
        if i % n != 2
            res[j] = n / 2
        end
    end
    res.keys.sort
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([3, 4.5], candidate.call(12))
  end
end
