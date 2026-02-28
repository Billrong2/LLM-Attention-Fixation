def f(s)
  s[3..] + s[2] + s[5..8]
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("cwcuc", candidate.call("jbucwc"))
  end
end
