def f(cat)
    digits = 0
    cat.each_char do |char|
        if char.match?(/\d/)
            digits += 1
        end
    end
    digits
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(5, candidate.call("C24Bxxx982ab"))
  end
end
