def f(text)
    punctuations = '!.?,:;'
    punctuations.each_char do |punct|
        if text.count(punct) > 1
            return 'no'
        end
        if text.end_with?(punct)
            return 'no'
        end
    end
    return text.capitalize
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("Djhasghasgdha", candidate.call("djhasghasgdha"))
  end
end
