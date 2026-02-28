def f(text)
    ls = text.split
    lines = ls.values_at(*(0..ls.size).step(3)).join(" ").split
    res = []
    (0..1).each do |i|
        ln = ls.values_at(*(1..ls.size).step(3))
        if 3 * i + 1 < ln.size
            res.push(ln.values_at(3 * i..3 * (i + 1) - 1).join(" "))
        end
    end
    lines + res
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(["echo"], candidate.call("echo hello!!! nice!"))
  end
end
