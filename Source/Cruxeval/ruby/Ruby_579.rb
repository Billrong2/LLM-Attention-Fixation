def f(text)
    if text == text.capitalize
        if text.length > 1 && text.downcase != text
            text[0].downcase + text[1..-1]
        end
    elsif text.match?(/\A[a-zA-Z]+\z/)
        text.capitalize
    end || text
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("", candidate.call(""))
  end
end
