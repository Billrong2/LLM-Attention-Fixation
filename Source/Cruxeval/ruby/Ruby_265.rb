def f(d, k)
    new_d = {}
    d.each { |key, val| new_d[key] = val if key < k }
    new_d
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({1 => 2, 2 => 4}, candidate.call({1 => 2, 2 => 4, 3 => 3}, 3))
  end
end
