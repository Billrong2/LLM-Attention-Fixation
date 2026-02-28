def f(val, text)
    indices = (0...text.length).select { |index| text[index] == val }
    if indices.empty?
        return -1
    else
        return indices[0]
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(-1, candidate.call("o", "fnmart"))
  end
end
