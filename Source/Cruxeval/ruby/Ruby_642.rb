def f(text)
    i = 0
    while i < text.length && text[i].strip.empty?
        i += 1
    end
    if i == text.length
        return 'space'
    end
    return 'no'
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("space", candidate.call("     "))
  end
end
