def f(text, x)
    if text.delete_prefix(x) == text
        f(text[1..-1], x)
    else
        text
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("djgblw asdl ", candidate.call("Ibaskdjgblw asdl ", "djgblw"))
  end
end
