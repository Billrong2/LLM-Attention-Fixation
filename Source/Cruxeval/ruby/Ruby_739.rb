def f(st, pattern)
    pattern.each do |p|
        return false unless st.start_with?(p)
        st = st[p.length..-1]
    end
    true
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(false, candidate.call("qwbnjrxs", ["jr", "b", "r", "qw"]))
  end
end
