def f(text, num_digits)
    width = [1, num_digits].max
    text.rjust(width, '0')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("00019", candidate.call("19", 5))
  end
end
