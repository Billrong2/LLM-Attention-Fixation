def f(c, st, ed)
    d = {}
    a, b = 0, 0
    c.each do |x, y|
        d[y] = x
        if y == st
            a = x
        end
        if y == ed
            b = x
        end
    end
    w = d[st]
    return a > b ? [w, b] : [b, w]
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(["TEXT", "CODE"], candidate.call({"TEXT" => 7, "CODE" => 3}, 7, 3))
  end
end
