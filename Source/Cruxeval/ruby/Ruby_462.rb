def f(text, value)
    length = text.length
    letters = text.split('')
    if !letters.include?(value)
        value = letters[0]
    end
    value * length
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("oooooooo", candidate.call("ldebgp o", "o"))
  end
end
