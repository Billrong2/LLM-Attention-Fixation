def f(dic)
  dic2 = dic.values.zip(dic.keys).to_h
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({"a" => -1, "b" => 0, "c" => 1}, candidate.call({-1 => "a", 0 => "b", 1 => "c"}))
  end
end
