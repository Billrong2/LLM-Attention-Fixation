def f(nums)
  nums.map { |val| val.rjust(nums[0].to_i, '0') }[1..-1].map(&:to_s)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(["2", "2", "44", "0", "7", "20257"], candidate.call(["1", "2", "2", "44", "0", "7", "20257"]))
  end
end
