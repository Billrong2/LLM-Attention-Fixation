def f(arr)
    counts = [0] * 9
    ans = []
    arr.each do |ele|
        counts[ele - 1] += 1
    end
    counts.length.times do |i|
        while counts[i] > 0
            counts[i] -= 1
            ans.push(i + 1)
        end
    end
    return counts, ans
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([[0, 0, 0, 0, 0, 0, 0, 0, 0], [3, 4, 6, 7, 8, 9]], candidate.call([6, 3, 0, 7, 4, 8]))
  end
end
