def f(text)
    text.each_char do |c|
        return false unless c.match?(/\d/)
    end
    !text.empty?
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(true, candidate.call("99"))
  end
end
