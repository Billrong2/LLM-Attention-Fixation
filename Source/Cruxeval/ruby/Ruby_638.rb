def f(s, suffix)
    return s if suffix.empty?
    
    while s.end_with?(suffix)
        s = s[0...-suffix.length]
    end
    
    s
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("ababa", candidate.call("ababa", "ab"))
  end
end
