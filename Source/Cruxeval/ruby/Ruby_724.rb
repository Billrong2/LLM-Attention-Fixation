def f(text, function)
    cites = [text[text.index(function) + function.length..-1].length]
    text.each_char do |char|
        if char == function
            cites << text[text.index(function) + function.length..-1].length
        end
    end
    return cites
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([3], candidate.call("010100", "010"))
  end
end
