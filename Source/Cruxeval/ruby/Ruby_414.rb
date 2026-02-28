def f(d)
  dCopy = d.clone
  dCopy.each do |key, value|
    value.map!(&:upcase)
  end
  dCopy
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({"X" => ["X", "Y"]}, candidate.call({"X" => ["x", "y"]}))
  end
end
