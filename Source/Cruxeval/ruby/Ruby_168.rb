def f(text, new_value, index)
    key = text[index].tr(text[index], new_value)
    text.tr(text[index], key)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("spaib", candidate.call("spain", "b", 4))
  end
end
