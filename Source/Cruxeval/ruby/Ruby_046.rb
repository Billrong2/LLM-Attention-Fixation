def f(l, c)
    l.join(c)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("manylettersasvszhelloman", candidate.call(["many", "letters", "asvsz", "hello", "man"], ""))
  end
end
