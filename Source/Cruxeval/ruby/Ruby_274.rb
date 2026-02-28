def f(nums, target)
    count = 0
    nums.each do |n1|
        nums.each do |n2|
            count += 1 if n1 + n2 == target
        end
    end
    count
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(3, candidate.call([1, 2, 3], 4))
  end
end
