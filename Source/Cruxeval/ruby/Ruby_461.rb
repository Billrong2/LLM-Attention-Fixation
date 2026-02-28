def f(text, search)
    search.start_with?(text) || false
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(true, candidate.call("123", "123eenhas0"))
  end
end
