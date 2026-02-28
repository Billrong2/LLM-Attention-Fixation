def f(text, digit)
    count = text.count(digit)
    return digit.to_i * count
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(7, candidate.call("7Ljnw4Lj", "7"))
  end
end
