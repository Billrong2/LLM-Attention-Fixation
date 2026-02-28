def f(text)
    s = text.split("\n")
    s.length
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(3, candidate.call("145

12fjkjg"))
  end
end
