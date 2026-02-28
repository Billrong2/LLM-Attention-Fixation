def f(text, delimiter)
    text = text.rpartition(delimiter)
    text[0] + text[-1]
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("xxjarcz", candidate.call("xxjarczx", "x"))
  end
end
