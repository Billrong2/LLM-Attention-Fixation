def f(text, value)
    left, _, right = text.partition(value)
    right + left
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("j rinpxdif", candidate.call("difkj rinpx", "k"))
  end
end
