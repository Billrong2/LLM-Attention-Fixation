def f(line, equalityMap)
    rs = Hash[equalityMap.map { |k| [k[0], k[1]] }]
    line.tr(rs.keys.join, rs.values.join)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("baba", candidate.call("abab", [["a", "b"], ["b", "a"]]))
  end
end
