def f(txt, alpha)
    txt = txt.sort
    if txt.index(alpha) % 2 == 0
        txt.reverse
    end
    txt
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(["2", "3", "4", "7", "8", "9"], candidate.call(["8", "9", "7", "4", "3", "2"], "9"))
  end
end
