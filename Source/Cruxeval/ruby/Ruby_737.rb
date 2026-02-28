def f(nums)
    counts = 0
    nums.each do |i|
        if i.to_s.match?(/^\d+$/)
            if counts == 0
                counts += 1
            end
        end
    end
    counts
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(1, candidate.call([0, 6, 2, -1, -2]))
  end
end
