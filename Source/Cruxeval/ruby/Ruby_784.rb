def f(key, value)
    dict_ = {key => value}
    dict_.shift
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(["read", "Is"], candidate.call("read", "Is"))
  end
end
