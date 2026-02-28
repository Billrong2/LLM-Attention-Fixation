def f(text)
    text = text.sub(' x', ' x.')
    if text.split.all? { |word| word == word.capitalize }
        return 'correct'
    end
    text = text.sub(' x.', ' x')
    'mixed'
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("correct", candidate.call("398 Is A Poor Year To Sow"))
  end
end
