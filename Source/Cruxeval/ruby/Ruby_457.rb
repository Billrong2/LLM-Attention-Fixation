def f(nums)
    count = Array.new(nums.length) { |i| i }
    nums.length.times do |i|
        nums.pop
        count.shift unless count.empty?
    end
    nums
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([], candidate.call([3, 1, 7, 5, 6]))
  end
end
