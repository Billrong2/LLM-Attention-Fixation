def f(string)
    upper = 0
    string.each_char do |c|
        if c == c.upcase
            upper += 1
        end
    end
    upper * [2, 1][upper % 2]
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(8, candidate.call("PoIOarTvpoead"))
  end
end
