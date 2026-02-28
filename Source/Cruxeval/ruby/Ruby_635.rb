def f(text)
    valid_chars = ['-', '_', '+', '.', '/', ' ']
    text = text.upcase
    text.each_char do |char|
        return false if !char.match?(/[[:alnum:]]/) && !valid_chars.include?(char)
    end
    true
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(false, candidate.call("9.twCpTf.H7 HPeaQ^ C7I6U,C:YtW"))
  end
end
