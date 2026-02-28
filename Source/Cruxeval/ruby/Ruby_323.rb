def f(text)
    text.split("\n").length
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(1, candidate.call("ncdsdfdaaa0a1cdscsk*XFd"))
  end
end
