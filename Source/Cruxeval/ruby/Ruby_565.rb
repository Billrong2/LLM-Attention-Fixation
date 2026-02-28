def f(text)
    text.chars.map { |ch| text.index(ch) }.max
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(13, candidate.call("qsqgijwmmhbchoj"))
  end
end
