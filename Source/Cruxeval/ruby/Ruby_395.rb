def f(s)
  (0...s.length).each do |i|
    if s[i].match(/\d/)
      return i + (s[i] == '0' ? 1 : 0)
    elsif s[i] == '0'
      return -1
    end
  end
  return -1
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(0, candidate.call("11"))
  end
end
