def f(d)
    i = d.to_a.each
    return [i.next, i.next]
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([["a", 123], ["b", 456]], candidate.call({"a" => 123, "b" => 456, "c" => 789}))
  end
end
