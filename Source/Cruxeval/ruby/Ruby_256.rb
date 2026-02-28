def f(text, sub)
    a = 0
    b = text.length - 1

    while a <= b
        c = (a + b) / 2
        if text[c..-1].index(sub) != nil
            a = c + 1
        else
            b = c - 1
        end
    end

    a
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(0, candidate.call("dorfunctions", "2"))
  end
end
