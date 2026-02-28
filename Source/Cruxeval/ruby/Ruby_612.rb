def f(d)
    d.to_h
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({"a" => 42, "b" => 1337, "c" => -1, "d" => 5}, candidate.call({"a" => 42, "b" => 1337, "c" => -1, "d" => 5}))
  end
end
