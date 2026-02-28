def f(text)
    k, l = 0, text.length - 1
    while !text[l].match?(/[[:alpha:]]/)
        l -= 1
    end
    while !text[k].match?(/[[:alpha:]]/)
        k += 1
    end
    if k != 0 || l != text.length - 1
        text[k..l]
    else
        text[0]
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("t", candidate.call("timetable, 2mil"))
  end
end
