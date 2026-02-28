def f(text, chars)
    chars = chars.split('')
    text = text.split('')
    new_text = text
    while new_text.length > 0 && text.length > 0
        if chars.include?(new_text[0])
            new_text = new_text[1..-1]
        else
            break
        end
    end
    new_text.join('')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("sfdellos", candidate.call("asfdellos", "Ta"))
  end
end
