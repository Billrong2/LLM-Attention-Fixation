def f(text, suffix)
    suffix = nil if suffix == ''
    text.end_with?(suffix)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(false, candidate.call("uMeGndkGh", "kG"))
  end
end
