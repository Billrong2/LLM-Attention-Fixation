def f(text)
    text = text.split('')
    (text.length - 1).downto(0) do |i|
        if text[i].strip.empty?
            text[i] = '&nbsp;'
        end
    end
    text.join('')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("&nbsp;&nbsp;&nbsp;", candidate.call("   "))
  end
end
