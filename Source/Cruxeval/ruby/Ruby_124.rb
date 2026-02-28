def f(txt, sep, sep_count)
    o = ''
    while sep_count > 0 && txt.count(sep) > 0
        o += txt.rpartition(sep)[0] + sep
        txt = txt.rpartition(sep)[2]
        sep_count -= 1
    end
    o + txt
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("i like you", candidate.call("i like you", " ", -1))
  end
end
