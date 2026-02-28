def f(n)
    n.to_s.each_char do |i|
        if !i.match?(/\d/)
            n = -1
            break
        end
    end
    n
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(-1, candidate.call("6 ** 2"))
  end
end
