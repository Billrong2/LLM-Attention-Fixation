def f(s, o)
    if s.start_with?(o)
        return s
    end
    return o + f(s, o.reverse.chop.reverse)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("bababba", candidate.call("abba", "bab"))
  end
end
