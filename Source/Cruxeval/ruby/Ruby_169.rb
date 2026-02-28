def f(text)
    ls = text.split('')
    total = (text.length - 1) * 2
    for i in 1..total
        if i.odd?
            ls << '+'
        else
            ls.insert(0, '+')
        end
    end
    ls.join('').rjust(total)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("++++taole++++", candidate.call("taole"))
  end
end
