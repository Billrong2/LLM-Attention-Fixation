def f(text, substr, occ)
    n = 0
    while true
        i = text.rindex(substr)
        if i == nil
            break
        elsif n == occ
            return i
        else
            n += 1
            text = text[0...i]
        end
    end
    return -1
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(-1, candidate.call("zjegiymjc", "j", 2))
  end
end
