def f(text)
    text.each_char do |char|
        return false if !char.match(/\s/)
    end
    true
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(false, candidate.call("     i"))
  end
end
