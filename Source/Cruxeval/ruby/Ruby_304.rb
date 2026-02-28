def f(d)
    key1 = d.sort_by { |k, v| k }.reverse[0][0]
    val1 = d.delete(key1)
    key2 = d.sort_by { |k, v| k }.reverse[0][0]
    val2 = d.delete(key2)
    { key1 => val1, key2 => val2 }
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({87 => 7, 18 => 6}, candidate.call({2 => 3, 17 => 3, 16 => 6, 18 => 6, 87 => 7}))
  end
end
