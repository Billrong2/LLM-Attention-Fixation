def f(lists)
    lists[1].clear
    lists[2] += lists[1]
    lists[0]
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([395, 666, 7, 4], candidate.call([[395, 666, 7, 4], [], [4223, 111]]))
  end
end
