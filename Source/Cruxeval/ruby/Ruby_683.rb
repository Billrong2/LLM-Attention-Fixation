def f(dict1, dict2)
  result = dict1.clone
  dict2.each { |key, value| result[key] = value }
  result
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({"disface" => 9, "cam" => 7, "mforce" => 5}, candidate.call({"disface" => 9, "cam" => 7}, {"mforce" => 5}))
  end
end
