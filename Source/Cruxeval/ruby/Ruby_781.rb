def f(s, ch)
    return '' unless s.include?(ch)
    s = s.partition(ch)[2].reverse
    s.length.times do
        s = s.partition(ch)[2].reverse
    end
    s
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("", candidate.call("shivajimonto6", "6"))
  end
end
