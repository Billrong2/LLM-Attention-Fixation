def f(nums)
  verdict = ->(x) { x < 2 }
  res = nums.reject(&:zero?)
  result = res.map { |x| [x, verdict.call(x)] }
  if result.empty?
    'error - no numbers or all zeros!'
  else
    result
  end
end

require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([[3, false], [1, true]], candidate.call([0, 3, 0, 1]))
  end
end
