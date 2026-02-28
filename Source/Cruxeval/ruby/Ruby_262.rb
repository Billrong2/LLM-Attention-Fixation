def f(nums)
    count = nums.length
    score = {0 => "F", 1 => "E", 2 => "D", 3 => "C", 4 => "B", 5 => "A", 6 => ""}
    result = []
    count.times do |i|
        result << score[nums[i]]
    end
    result.join('')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("BA", candidate.call([4, 5]))
  end
end
