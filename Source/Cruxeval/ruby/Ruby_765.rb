def f(text)
    text.scan(/\d/).count
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(3, candidate.call("so456"))
  end
end
