def f(d, rm)
  res = d.dup
  rm.each do |k|
    res.delete(k) if res.key?(k)
  end
  res
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({"1" => "b"}, candidate.call({"1" => "a", 1 => "a", 1 => "b", "1" => "b"}, [1]))
  end
end
