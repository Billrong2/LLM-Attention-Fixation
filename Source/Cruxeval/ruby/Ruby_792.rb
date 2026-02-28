def f(l1, l2)
    return {} if l1.length != l2.length
    Hash[l1.collect { |item| [item, l2] }]
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({"a" => ["car", "dog"], "b" => ["car", "dog"]}, candidate.call(["a", "b"], ["car", "dog"]))
  end
end
