def f(ints)
    counts = Array.new(301, 0)

    ints.each do |i|
        counts[i] += 1
    end

    r = []
    counts.each_with_index do |count, i|
        if count >= 3
            r << i.to_s
        end
    end
    counts.clear
    r.join(' ')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("2", candidate.call([2, 3, 5, 2, 4, 5, 2, 89]))
  end
end
