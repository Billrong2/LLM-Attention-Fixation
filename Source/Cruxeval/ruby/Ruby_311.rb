def f(text)
    text = text.gsub('#', '1').gsub('$', '5')
    text.match?(/^\d+$/) ? 'yes' : 'no'
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("no", candidate.call("A"))
  end
end
