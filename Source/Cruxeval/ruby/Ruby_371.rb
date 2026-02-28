def f(nums)
    nums.select! { |odd| odd % 2 == 0 }
    sum_ = 0
    nums.each { |num| sum_ += num }
    sum_
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(0, candidate.call([11, 21, 0, 11]))
  end
end
