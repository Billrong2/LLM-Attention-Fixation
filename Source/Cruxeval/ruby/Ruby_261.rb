def f(nums, target)
    lows = []
    higgs = []
    nums.each do |i|
        if i < target
            lows << i
        else
            higgs << i
        end
    end
    lows.clear
    return lows, higgs
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([[], [12, 516, 5, 214, 51]], candidate.call([12, 516, 5, 2, 3, 214, 51], 5))
  end
end
