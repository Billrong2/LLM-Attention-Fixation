def f(text, n)
    if n < 0 || text.length <= n
        return text
    end
    result = text[0..n]
    i = result.length - 1
    while i >= 0
        if result[i] != text[i]
            break
        end
        i -= 1
    end
    return text[0..i]
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("bR", candidate.call("bR", -1))
  end
end
