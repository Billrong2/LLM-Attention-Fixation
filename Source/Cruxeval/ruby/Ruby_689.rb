def f(arr)
    count = arr.length
    sub = arr.dup
    (0...count).step(2).each do |i|
        sub[i] *= 5
    end
    sub
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([-15, -6, 10, 7], candidate.call([-3, -6, 2, 7]))
  end
end
