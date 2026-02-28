def f(text, letter)
    if letter == letter.downcase
        letter = letter.upcase
    end
    text = text.chars.map { |char| char == letter.downcase ? letter : char }.join('')
    text.capitalize
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("E wrestled evil until upperfeat", candidate.call("E wrestled evil until upperfeat", "e"))
  end
end
