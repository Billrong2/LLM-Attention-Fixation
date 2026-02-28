def f(text, char, min_count)
    count = text.count(char)
    if count < min_count
        text.swapcase
    else
        text
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("wwwwhhhtttpp", candidate.call("wwwwhhhtttpp", "w", 3))
  end
end
