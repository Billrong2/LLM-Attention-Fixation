def f(text)
    s = 0
    for i in 1..text.length-1
        s += text.rpartition(text[i])[0].length
    end
    return s
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(3, candidate.call("wdj"))
  end
end
