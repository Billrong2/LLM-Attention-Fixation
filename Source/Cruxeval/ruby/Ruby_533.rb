def f(query, base)
  net_sum = 0
  base.each do |key, val|
    if key[0] == query && key.length == 3
      net_sum -= val
    elsif key[-1] == query && key.length == 3
      net_sum += val
    end
  end
  net_sum
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(0, candidate.call("a", {}))
  end
end
