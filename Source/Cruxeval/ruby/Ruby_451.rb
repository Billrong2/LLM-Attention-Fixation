def f(text, char)
    text = text.split('')
    text.each_with_index do |item, index|
        if item == char
            text.delete_at(index)
            return text.join('')
        end
    end
    return text
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("n", candidate.call("pn", "p"))
  end
end
