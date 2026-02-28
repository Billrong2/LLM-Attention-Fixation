def f(text, fill, size)
    if size < 0
        size = -size
    end
    if text.length > size
        return text[text.length - size..-1]
    else
        return text.rjust(size, fill)
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("w", candidate.call("no asw", "j", 1))
  end
end
