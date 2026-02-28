def f(d)
    d = d.dup
    d.delete(d.keys.last)
    d
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({"l" => 1, "t" => 2}, candidate.call({"l" => 1, "t" => 2, "x:" => 3}))
  end
end
