def f(values, value)
    length = values.length
    new_dict = values.product([value]).to_h
    new_dict[values.sort.join('')] = value * 3
    new_dict
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({"0" => 117, "3" => 117, "03" => 351}, candidate.call(["0", "3"], 117))
  end
end
