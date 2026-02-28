def f(text, pref)
    if text.start_with?(pref)
        n = pref.length
        text = text[n..-1].split('.')[1..-1].join('.')
    end
    text
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("dq", candidate.call("omeunhwpvr.dq", "omeunh"))
  end
end
