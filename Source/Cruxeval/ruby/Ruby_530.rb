def f(s, ch)
  if s.include?(ch)
    sl = s.sub(/^#{ch}+/,'')
    if sl.length == 0
      sl = '!?'
    end
    sl
  else
    'no'
  end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("ff", candidate.call("@@@ff", "@"))
  end
end
