def f(text, space_symbol, size)
    spaces = space_symbol * (size - text.length)
    text + spaces
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("w))))))))))))", candidate.call("w", "))", 7))
  end
end
