def f(s, char)
    base = char * (s.count(char) + 1)
    s.delete_suffix(base)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("mnmnj krupa...##!@#!@#$$@##", candidate.call("mnmnj krupa...##!@#!@#$$@##", "@"))
  end
end
