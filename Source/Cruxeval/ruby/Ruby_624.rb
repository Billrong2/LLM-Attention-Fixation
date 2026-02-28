def f(text, char)
    char_index = text.index(char)
    result = []
    if char_index.nil?
        char_index = -1
    end
    if char_index > 0
        result = text[0, char_index].split('')
    end
    result.concat(char.split('')).concat(text[char_index+char.length..-1].split(''))
    result.join('')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("xllomnrpc", candidate.call("llomnrpc", "x"))
  end
end
