def f(name)
  [name[0], name[1].reverse[0]]
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(["m", "a"], candidate.call("master. "))
  end
end
