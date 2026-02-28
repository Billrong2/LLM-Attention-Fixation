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
    assert_equal("wslh0762m934", candidate.call("439m2670hlsw", 3))
  end
end
