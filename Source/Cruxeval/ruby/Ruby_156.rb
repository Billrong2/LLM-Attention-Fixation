def f(text, limit, char)
    if limit < text.length
        text[0...limit]
    else
        text.ljust(limit, char)
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("tqzym", candidate.call("tqzym", 5, "c"))
  end
end
