def f(chars)
    s = ""
    chars.each_char do |ch|
        if chars.count(ch) % 2 == 0
            s += ch.upcase
        else
            s += ch
        end
    end
    s
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("aCbCed", candidate.call("acbced"))
  end
end
