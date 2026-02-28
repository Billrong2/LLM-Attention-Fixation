def f(phrase)
    result = ''
    phrase.each_char do |i|
        if !i.match?(/[[:lower:]]/)
            result += i
        end
    end
    result
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("DFA.", candidate.call("serjgpoDFdbcA."))
  end
end
