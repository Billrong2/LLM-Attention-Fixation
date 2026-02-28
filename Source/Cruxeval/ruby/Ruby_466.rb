def f(text)
    length = text.length
    index = 0
    while index < length && text[index].match(/\s/)
        index += 1
    end
    return text[index, 5]
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("-----", candidate.call("-----	
	th
-----"))
  end
end
