def f(text)
    chars = []
    text.each_char do |c|
        if c.match?(/\d/)
            chars << c
        end
    end
    chars.reverse.join('')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("641524", candidate.call("--4yrw 251-//4 6p"))
  end
end
