def f(temp, timeLimit)
    s = timeLimit / temp
    e = timeLimit % temp
    s > 1 ? "#{s} #{e}" : "#{e} oC"
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("1234567890 0", candidate.call(1, 1234567890))
  end
end
