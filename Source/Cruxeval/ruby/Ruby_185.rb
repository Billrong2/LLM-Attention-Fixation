def f(l)
    n = l.length
    (1..n/2).each do |k|
        i = k - 1
        j = n - k
        while i < j
            # swap elements:
            l[i], l[j] = l[j], l[i]
            # update i, j:
            i += 1
            j -= 1
        end
    end
    l
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([11, 14, 7, 12, 9, 16], candidate.call([16, 14, 12, 7, 9, 11]))
  end
end
