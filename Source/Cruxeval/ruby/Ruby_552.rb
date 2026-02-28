def f(d)
  result = {}
  d.each do |k, v|
    if k.is_a?(Float)
      v.each do |i|
        result[i] = k
      end
    else
      result[k] = v
    end
  end
  result
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({2 => 0.76, 5 => [3, 6, 9, 12]}, candidate.call({2 => 0.76, 5 => [3, 6, 9, 12]}))
  end
end
