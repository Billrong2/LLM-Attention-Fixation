def f(text)
    s = text.downcase
    s.each_char do |c|
        return 'no' if c == 'x'
    end
    return text.upcase == text
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("no", candidate.call("dEXE"))
  end
end
