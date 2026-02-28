def f(text)
    my_list = text.split
    my_list.sort!.reverse!
    my_list.join(' ')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("loved a", candidate.call("a loved"))
  end
end
