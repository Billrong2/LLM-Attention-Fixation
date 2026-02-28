def f(s, x)
    count = 0
    while s[0, x.length] == x && count < s.length - x.length
        s = s[x.length..-1]
        count += x.length
    end
    s
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("If you want to live a happy life! Daniel", candidate.call("If you want to live a happy life! Daniel", "Daniel"))
  end
end
