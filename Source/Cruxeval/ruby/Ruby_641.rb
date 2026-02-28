def f(number)
    number.match?(/^\d+$/)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(false, candidate.call("dummy33;d"))
  end
end
