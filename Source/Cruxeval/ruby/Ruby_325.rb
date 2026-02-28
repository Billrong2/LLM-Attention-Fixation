def f(s)
    l = s.chars
    l.each_with_index do |char, i|
        l[i] = char.downcase
        return false if !char.match?(/\d/)
    end
    true
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(true, candidate.call(""))
  end
end
