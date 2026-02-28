def f(w)
    ls = w.split('')
    omw = ''
    while ls.length > 0 do
        omw += ls.shift
        if ls.length * 2 > w.length
            return w[ls.length..-1] == omw
        end
    end
    return false
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(false, candidate.call("flak"))
  end
end
