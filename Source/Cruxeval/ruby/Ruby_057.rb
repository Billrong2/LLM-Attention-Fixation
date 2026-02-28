def f(text)
    text = text.upcase
    count_upper = 0
    text.each_char do |char|
        if char == char.upcase
            count_upper += 1
        else
            return 'no'
        end
    end
    count_upper / 2
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(1, candidate.call("ax"))
  end
end
