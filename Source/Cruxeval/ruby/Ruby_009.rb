def f(t)
    t.each_char do |c|
        return false unless c.match?(/\d/)
    end
    true
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(false, candidate.call("#284376598"))
  end
end
