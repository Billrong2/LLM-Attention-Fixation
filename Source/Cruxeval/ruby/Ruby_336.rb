def f(s, sep)
    s += sep
    s.rpartition(sep)[0]
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("234dsfssdfs333324314", candidate.call("234dsfssdfs333324314", "s"))
  end
end
