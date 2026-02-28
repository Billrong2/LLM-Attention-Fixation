def f(s)
    if s[-5..].ascii_only?
        [s[-5..], s[0..2]]
    elsif s[0..4].ascii_only?
        [s[0..4], s[-5..][3..]]
    else
        s
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(["a1234", "år"], candidate.call("a1234år"))
  end
end
