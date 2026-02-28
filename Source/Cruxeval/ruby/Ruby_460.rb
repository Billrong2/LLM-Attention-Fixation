def f(text, amount)
    length = text.length
    pre_text = '|'
    if amount >= length
        extra_space = amount - length
        pre_text += ' ' * (extra_space / 2).to_i
        return pre_text + text + pre_text
    end
    text
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("GENERAL NAGOOR", candidate.call("GENERAL NAGOOR", 5))
  end
end
