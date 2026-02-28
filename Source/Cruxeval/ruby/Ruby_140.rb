def f(st)
    last_h = st.rindex('h') || -1
    last_i = st.rindex('i') || -1

    if last_h >= last_i
        return 'Hey'
    else
        return 'Hi'
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("Hey", candidate.call("Hi there"))
  end
end
