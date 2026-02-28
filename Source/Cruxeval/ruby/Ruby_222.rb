def f(mess, char)
    while mess.index(char, mess.rindex(char) + 1) != nil
        mess = mess[0..mess.rindex(char)] + mess[mess.rindex(char) + 2..]
    end
    mess
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("0aabbaa0b", candidate.call("0aabbaa0b", "a"))
  end
end
