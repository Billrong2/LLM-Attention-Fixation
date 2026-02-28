def f(text, char)
    length = text.length
    index = -1
    (0..length-1).each do |i|
        if text[i] == char
            index = i
        end
    end
    if index == -1
        index = length / 2
    end
    new_text = text.split('')
    new_text.delete_at(index)
    new_text.join('')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("o hoseto", candidate.call("o horseto", "r"))
  end
end
