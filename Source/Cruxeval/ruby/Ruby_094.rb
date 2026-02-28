def f(a, b)
  a.merge(b)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({"w" => 3, "wi" => 10}, candidate.call({"w" => 5, "wi" => 10}, {"w" => 3}))
  end
end
