def f(text)
    !text.match?(/^\d+$/)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(true, candidate.call("the speed is -36 miles per hour"))
  end
end
