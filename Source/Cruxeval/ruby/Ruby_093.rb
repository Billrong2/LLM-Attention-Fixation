def f(n)
    length = n.length + 2
    revn = n.chars.to_a
    result = revn.join
    revn.clear
    return result + '!' * length
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("iq!!!!", candidate.call("iq"))
  end
end
