def f(text)
    (text.length-1).downto(1) do |i|
        if text[i] != text[i].upcase
            return text[0...i]
        end
    end
    return ''
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("SzHjifnzo", candidate.call("SzHjifnzog"))
  end
end
