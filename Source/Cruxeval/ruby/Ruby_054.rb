def f(text, s, e)
    return -1 if text[s...e].empty?
    sublist = text[s...e].chars
    sublist.index(sublist.min)
end

require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(1, candidate.call("happy", 0, 3))
  end
end
