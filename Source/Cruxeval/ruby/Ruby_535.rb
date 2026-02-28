def f(n)
    n.to_s.split('').each do |digit|
        return false unless "012".include?(digit) || (5..9).include?(digit.to_i)
    end
    true
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(false, candidate.call(1341240312))
  end
end
