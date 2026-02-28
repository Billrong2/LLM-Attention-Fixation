def f(text, char)
    position = text.length
    if text.include?(char)
        position = text.index(char)
        if position > 1
            position = (position + 1) % text.length
        end
    end
    position
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(0, candidate.call("wduhzxlfk", "w"))
  end
end
