def f(text)
    number = 0
    text.each_char do |t|
        if t.match?(/\d/)
            number += 1
        end
    end
    number
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(0, candidate.call("Thisisastring"))
  end
end
