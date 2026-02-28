def f(text, value)
    length = text.length
    index = 0
    while length > 0
        value = text[index] + value
        length -= 1
        index += 1
    end
    value
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("tm oajhouse", candidate.call("jao mt", "house"))
  end
end
