def f(s, characters)
  characters.map { |i| s[i] }
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(["7", "6", "1", "7", " "], candidate.call("s7 6s 1ss", [1, 3, 6, 1, 2]))
  end
end
