def f(d)
    d.clear
    return d
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({}, candidate.call({"a" => "3", "b" => "-1", "c" => "Dum"}))
  end
end
