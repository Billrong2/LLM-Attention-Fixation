require 'set'

def f(a)
    if a == 0
        [0]
    else
        result = []
        while a > 0
            result << a % 10
            a = a / 10
        end
        result.reverse!
        result.join.to_i
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([0], candidate.call(0))
  end
end
