def f(text, position)
    length = text.length
    index = position % (length + 1)
    if position < 0 || index < 0
        index = -1
    end
    new_text = text.split('')
    new_text.delete_at(index)
    new_text.join('')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("udbs l", candidate.call("undbs l", 1))
  end
end
