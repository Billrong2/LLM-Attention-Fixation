def f(text)
    ans = ''
    while text != ''
        x, sep, text = text.partition('(')
        ans = x + sep.tr('(', '|') + ans
        ans = ans + text[0] + ans
        text = text[1..-1]
    end
    ans
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("", candidate.call(""))
  end
end
