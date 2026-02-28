def f(text, char)
    index = text.rindex(char)
    result = text.split('')
    while index > 0 do
        result[index] = result[index-1]
        result[index-1] = char
        index -= 2
    end
    result.join('')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("jqjfj zm", candidate.call("qpfi jzm", "j"))
  end
end
