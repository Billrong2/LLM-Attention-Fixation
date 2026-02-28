def f(d)
  sorted_pairs = d.sort_by { |k, v| [k.to_s.length + v.to_s.length, k, v] }
  sorted_pairs.select { |k, v| k < v }
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([[1, 3], [4, 555]], candidate.call({55 => 4, 4 => 555, 1 => 3, 99 => 21, 499 => 4, 71 => 7, 12 => 6}))
  end
end
