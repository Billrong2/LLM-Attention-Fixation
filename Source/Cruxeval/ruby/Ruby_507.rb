def f(text, search)
    result = text.downcase
    result.index(search.downcase)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(0, candidate.call("car hat", "car"))
  end
end
