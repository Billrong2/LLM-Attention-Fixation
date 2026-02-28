def f(s, l)
    s.ljust(l, '=').rpartition('=')[0]
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("urecord", candidate.call("urecord", 8))
  end
end
