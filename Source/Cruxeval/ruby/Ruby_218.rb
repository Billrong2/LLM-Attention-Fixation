def f(string, sep)
    cnt = string.scan(/#{Regexp.escape(sep)}/).count
    ((string + sep) * cnt).reverse
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("bacfbacfcbaacbacfbacfcbaac", candidate.call("caabcfcabfc", "ab"))
  end
end
