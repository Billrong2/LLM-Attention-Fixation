def f(obj)
    obj.each do |k, v|
        obj[k] = -v if v >= 0
    end
    obj
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({"R" => 0, "T" => -3, "F" => -6, "K" => 0}, candidate.call({"R" => 0, "T" => 3, "F" => -6, "K" => 0}))
  end
end
