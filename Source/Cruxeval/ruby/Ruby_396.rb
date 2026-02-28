def f(ets)
    while !ets.empty?
        k, v = ets.shift
        ets[k] = v**2
    end
    return ets
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({}, candidate.call({}))
  end
end
