def f(text)
    short = ''
    text.each_char do |c|
        if c.match?(/[a-z]/)
            short += c
        end
    end
    short
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("jiojickldl", candidate.call("980jio80jic kld094398IIl "))
  end
end
