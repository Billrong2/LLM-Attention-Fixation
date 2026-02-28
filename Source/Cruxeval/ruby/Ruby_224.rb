def f(array, value)
    array.reverse
    array.pop
    odd = []
    while array.length > 0
        tmp = {}
        tmp[array.pop] = value
        odd.push(tmp)
    end
    result = {}
    while odd.length > 0
        result = result.merge(odd.pop)
    end
    result
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({}, candidate.call(["23"], 123))
  end
end
