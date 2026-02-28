def f(n)
    streak = ''
    n.to_s.each_char do |c|
        streak += c.ljust(c.to_i * 2)
    end
    streak
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("1 ", candidate.call(1))
  end
end
