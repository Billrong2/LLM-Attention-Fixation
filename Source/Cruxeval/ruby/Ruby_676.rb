def f(text, tab_size)
    text.gsub("\t", ' ' * tab_size)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("a", candidate.call("a", 100))
  end
end
