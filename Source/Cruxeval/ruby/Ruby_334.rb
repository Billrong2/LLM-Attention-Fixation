def f(a, b)
    b.join(a)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("nU00 9 rCSAz00w00 lpA5BO00sizL00i7rlVr", candidate.call("00", ["nU", " 9 rCSAz", "w", " lpA5BO", "sizL", "i7rlVr"]))
  end
end
