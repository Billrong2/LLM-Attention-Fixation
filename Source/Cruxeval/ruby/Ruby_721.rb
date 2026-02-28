def f(nums)
    count = nums.length
    (2...count).each do |num|
        nums.sort!
    end
    nums
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([-8, -7, -6, -5, 2], candidate.call([-6, -5, -7, -8, 2]))
  end
end
