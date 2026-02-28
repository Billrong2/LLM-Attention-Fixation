def f(x)
    if x.empty?
        return -1
    else
        cache = {}
        x.each do |item|
            if cache.key?(item)
                cache[item] += 1
            else
                cache[item] = 1
            end
        end
        return cache.values.max
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(4, candidate.call([1, 0, 2, 2, 0, 0, 0, 1]))
  end
end
