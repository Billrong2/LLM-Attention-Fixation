def f(strands)
    subs = strands.dup
    subs.each_with_index do |j, i|
        (j.length / 2).times do
            subs[i] = subs[i][-1] + subs[i][1..-2] + subs[i][0]
        end
    end
    subs.join
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("__1.00r__j_a6__6", candidate.call(["__", "1", ".", "0", "r0", "__", "a_j", "6", "__", "6"]))
  end
end
