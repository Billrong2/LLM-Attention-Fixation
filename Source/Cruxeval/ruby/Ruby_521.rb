def f(nums)
    m = nums.max
    m.times do
        nums.reverse!
    end
    nums
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([77, 9, 0, 2, 5, 77, 4, 0, 43], candidate.call([43, 0, 4, 77, 5, 2, 0, 9, 77]))
  end
end
