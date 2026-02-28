def f(text, value)
    indexes = []
    text.split('').each_with_index do |char, i|
        if char == value and (i == 0 or text[i-1] != value)
            indexes.push(i)
        end
    end
    if indexes.length % 2 == 1
        return text
    end
    return text[indexes[0]+1, indexes[-1]-1]
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("tr", candidate.call("btrburger", "b"))
  end
end
