def f(s1, s2)
    if s2.end_with?(s1)
        s2 = s2[0...-s1.length]
    end
    s2
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("hello", candidate.call("he", "hello"))
  end
end
