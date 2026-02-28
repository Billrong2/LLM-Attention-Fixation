def f(text, chars)
    listchars = chars.split('')
    first = listchars.pop
    listchars.each do |i|
        text = text[0, text.index(i)] + i + text[text.index(i)+1, text.length]
    end
    text
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("tflb omn rtt", candidate.call("tflb omn rtt", "m"))
  end
end
