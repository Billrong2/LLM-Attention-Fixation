def f(nums)
    digits = nums.select { |num| (num.is_a?(String) && num.match?(/\A\d+\z/)) || num.is_a?(Integer) }
    digits.map!(&:to_i)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([0, 6, 1, 2, 0], candidate.call([0, 6, "1", "2", 0]))
  end
end
