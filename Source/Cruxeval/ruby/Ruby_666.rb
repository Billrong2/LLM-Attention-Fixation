def f(d1, d2)
    mmax = 0
    d1.keys.each do |k1|
        p = d1[k1].length + d2[k1].to_a.length
        if p > mmax
            mmax = p
        end
    end
    mmax
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(4, candidate.call({0 => [], 1 => []}, {0 => [0, 0, 0, 0], 2 => [2, 2, 2]}))
  end
end
