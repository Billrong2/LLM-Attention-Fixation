def f(text)
    text_list = text.chars.map(&:swapcase)
    text_list.join
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("AKa?RIU", candidate.call("akA?riu"))
  end
end
