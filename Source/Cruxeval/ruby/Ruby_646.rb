def f(text, count)
  count.times do
    text = text.reverse
  end
  text
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("aBc, ,SzY", candidate.call("aBc, ,SzY", 2))
  end
end
