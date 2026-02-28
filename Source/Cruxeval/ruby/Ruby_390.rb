def f(text)
    if text.strip.empty?
        text.strip.length
    else
        nil
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(0, candidate.call(" 	 "))
  end
end
