def f(start, last, interval)
    steps = (start..last).step(interval).to_a
    steps[-1] = last + 1 if steps.include?(1)
    steps.length
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(8, candidate.call(3, 10, 1))
  end
end
