def f(keys, value)
    d = keys.each_with_object({}) { |k, h| h[k] = value }
    d.each_with_index do |(k, v), i|
        d.delete(i+1) if v == d[i+1]
    end
    d
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({}, candidate.call([1, 2, 1, 1], 3))
  end
end
