def f(s, from_c, to_c)
    s.tr(from_c, to_c)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("aph?d", candidate.call("aphid", "i", "?"))
  end
end
