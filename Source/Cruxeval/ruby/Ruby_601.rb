def f(text)
    t = 5
    tab = []
    text.each_char do |i|
        if ['a', 'e', 'i', 'o', 'u', 'y'].include?(i.downcase)
            tab << i.upcase * t
        else
            tab << i * t
        end
    end
    tab.join(' ')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("ccccc sssss hhhhh AAAAA rrrrr ppppp", candidate.call("csharp"))
  end
end
