def f(text, value)
    text.delete_prefix(value.downcase)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("cifysu", candidate.call("coscifysu", "cos"))
  end
end
