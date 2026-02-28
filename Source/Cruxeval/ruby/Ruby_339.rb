def f(array, elem)
    elem = elem.to_s
    d = 0
    array.each do |i|
        if i.to_s == elem
            d += 1
        end
    end
    d
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(2, candidate.call([-1, 2, 1, -8, -8, 2], 2))
  end
end
