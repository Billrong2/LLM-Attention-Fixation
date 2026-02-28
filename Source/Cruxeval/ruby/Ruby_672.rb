def f(text, position, value)
    length = text.length
    index = (position % (length + 2)) - 1
    if index >= length || index < 0
        return text
    end
    text_list = text.chars
    text_list[index] = value
    text_list.join('')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("1zd", candidate.call("1zd", 0, "m"))
  end
end
