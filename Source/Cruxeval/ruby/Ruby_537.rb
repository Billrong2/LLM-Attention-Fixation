def f(text, value)
    new_text = text.split('')
    begin
        new_text << value
        length = new_text.length
    rescue IndexError
        length = 0
    end
    '[' + length.to_s + ']'
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("[4]", candidate.call("abv", "a"))
  end
end
