def f(text)
    s = text.rpartition('o')
    div = s[0] == '' ? '-' : s[0]
    div2 = s[2] == '' ? '-' : s[2]
    return s[1] + div + s[1] + div2
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("-kkxkxxfck", candidate.call("kkxkxxfck"))
  end
end
