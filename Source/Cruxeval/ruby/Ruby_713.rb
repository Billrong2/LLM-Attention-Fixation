def f(text, char)
    if text.include?(char)
        text = text.split(char).map(&:strip).reject(&:empty?)
        return true if text.size > 1
    end
    false
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(true, candidate.call("only one line", " "))
  end
end
