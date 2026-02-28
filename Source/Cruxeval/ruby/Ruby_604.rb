def f(text, start)
    text.start_with?(start)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(true, candidate.call("Hello world", "Hello"))
  end
end
