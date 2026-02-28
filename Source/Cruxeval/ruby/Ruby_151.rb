def f(text)
    text.each_char do |c|
        if c.match?(/\d/)
            if c == '0'
                c = '.'
            else
                c = c == '1' ? '.' : '0'
            end
        end
    end
    text.chars.map { |c| c == '.' ? '0' : c }.join
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("697 this is the ultimate 7 address to attack", candidate.call("697 this is the ultimate 7 address to attack"))
  end
end
