def f(st)
    swapped = ''
    st.reverse.each_char { |ch| swapped += ch.swapcase }
    swapped
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("mgItr", candidate.call("RTiGM"))
  end
end
