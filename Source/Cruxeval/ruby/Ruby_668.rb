def f(text)
    text[-1] + text[0...-1]
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("rhellomyfriendea", candidate.call("hellomyfriendear"))
  end
end
