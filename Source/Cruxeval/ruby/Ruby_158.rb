def f(arr)
    n = arr.select { |item| item.even? }
    m = n + arr
    m.each do |i|
        if m.index(i) >= n.length
            m.delete(i)
        end
    end
    return m
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([6, 4, -2, 6, 4, -2], candidate.call([3, 6, 4, -2, 5]))
  end
end
