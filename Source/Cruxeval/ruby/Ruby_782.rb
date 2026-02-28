def f(input)
  input.each_char do |char|
    return false if char == char.upcase
  end
  true
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(false, candidate.call("a j c n x X k"))
  end
end
