def f(nums)
  count = 0
  while nums.length > 0
    if count % 2 == 0
      nums.pop
    else
      nums.shift
    end
    count += 1
  end
  nums
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([], candidate.call([3, 2, 0, 0, 2, 3]))
  end
end
