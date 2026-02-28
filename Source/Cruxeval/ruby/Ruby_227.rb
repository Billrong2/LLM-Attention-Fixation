def f(text)
    text = text.downcase
    head, tail = text[0], text[1..-1]
    head.upcase + tail
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("Manolo", candidate.call("Manolo"))
  end
end
