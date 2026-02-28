def f(text)
    text.ascii_only?
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(false, candidate.call("wW의IV]HDJjhgK[dGIUlVO@Ess$coZkBqu[Ct"))
  end
end
