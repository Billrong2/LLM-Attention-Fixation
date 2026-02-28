def f(text)
    b = true
    text.each_char do |x|
        if x.match?(/\d/)
            b = true
        else
            b = false
            break
        end
    end
    return b
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(false, candidate.call("-1-3"))
  end
end
