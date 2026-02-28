def f(perc, full)
    reply = ""
    i = 0
    while perc[i] == full[i] && i < full.length && i < perc.length do
        if perc[i] == full[i]
            reply += "yes "
        else
            reply += "no "
        end
        i += 1
    end
    reply
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("yes ", candidate.call("xabxfiwoexahxaxbxs", "xbabcabccb"))
  end
end
