def f(text, rules)
  rules.each do |rule|
    if rule == '@'
      text = text.reverse
    elsif rule == '~'
      text = text.upcase
    elsif text && text[-1] == rule
      text = text[0...-1]
    end
  end
  text
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("HI~", candidate.call("hi~!", ["~", "`", "!", "&"]))
  end
end
