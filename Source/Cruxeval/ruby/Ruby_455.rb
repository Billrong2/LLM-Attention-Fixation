def f(text)
    uppers = 0
    text.each_char do |c|
        uppers += 1 if c == c.upcase
    end
    uppers >= 10 ? text.upcase : text
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("?XyZ", candidate.call("?XyZ"))
  end
end
