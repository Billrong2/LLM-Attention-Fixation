def f(text)
    t = text
    text.each_char do |i|
        text = text.gsub(i, '')
    end
    text.length.to_s + t
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("0ThisIsSoAtrocious", candidate.call("ThisIsSoAtrocious"))
  end
end
