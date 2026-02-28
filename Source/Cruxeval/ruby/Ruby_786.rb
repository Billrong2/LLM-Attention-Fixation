def f(text, letter)
    if text.include?(letter)
        start = text.index(letter)
        text[start + 1..-1] + text[0..start]
    else
        text
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("kefp719", candidate.call("19kefp7", "9"))
  end
end
