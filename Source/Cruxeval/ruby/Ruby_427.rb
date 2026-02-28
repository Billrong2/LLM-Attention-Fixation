def f(s)
    count = s.length - 1
    reverse_s = s.reverse
    while count > 0 && reverse_s.scan(/sea/).empty?
        count -= 1
        reverse_s = reverse_s.slice(0, count)
    end
    reverse_s.slice(count..-1)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("", candidate.call("s a a b s d s a a s a a"))
  end
end
