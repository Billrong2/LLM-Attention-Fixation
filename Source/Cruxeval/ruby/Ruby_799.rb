def f(st)
    if st[0] == '~'
        e = st.rjust(10, 's')
        f(e)
    else
        st.rjust(10, 'n')
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("neqe-;ew22", candidate.call("eqe-;ew22"))
  end
end
