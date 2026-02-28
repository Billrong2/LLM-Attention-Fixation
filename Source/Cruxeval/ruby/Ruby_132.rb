def f(a_str, prefix)
  if a_str.delete_prefix(prefix)
    a_str
  else
    prefix + a_str
  end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("abc", candidate.call("abc", "abcd"))
  end
end
