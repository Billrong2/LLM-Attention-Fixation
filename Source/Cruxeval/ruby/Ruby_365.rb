def f(n, s)
    if s.start_with?(n)
        pre, _ = s.split(n, 2)
        return pre + n + s[n.length..-1]
    end
    s
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("mRcwVqXsRDRb", candidate.call("xqc", "mRcwVqXsRDRb"))
  end
end
