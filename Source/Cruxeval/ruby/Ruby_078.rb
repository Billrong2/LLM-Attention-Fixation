require 'set'

def f(text)
    if text && text == text.upcase
        cs = Hash[string.ascii_uppercase.each_char.zip(string.ascii_lowercase.each_char)]
        text.tr(cs.keys.join, cs.values.join)
    else
        text.downcase[0, 3]
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("mty", candidate.call("mTYWLMwbLRVOqNEf.oLsYkZORKE[Ko[{n"))
  end
end
