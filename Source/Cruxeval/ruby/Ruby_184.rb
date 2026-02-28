def f(digits)
    digits.reverse!
    if digits.length < 2
        return digits
    end
    (0...digits.length).step(2).each do |i|
        digits[i], digits[i+1] = digits[i+1], digits[i] if i+1 < digits.length
    end
    digits
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([1, 2], candidate.call([1, 2]))
  end
end
