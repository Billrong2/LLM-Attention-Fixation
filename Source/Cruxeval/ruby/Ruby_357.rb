def f(s)
    r = []
    (s.length - 1).downto(0).each do |i|
        r << s[i]
    end
    r.join('')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("werc", candidate.call("crew"))
  end
end
