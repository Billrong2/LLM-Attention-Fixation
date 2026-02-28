def f(text)
    index = 1
    while index < text.length
        if text[index] != text[index - 1]
            index += 1
        else
            text1 = text[0...index]
            text2 = text[index..-1].swapcase
            return text1 + text2
        end
    end
    text.swapcase
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("usAr", candidate.call("USaR"))
  end
end
