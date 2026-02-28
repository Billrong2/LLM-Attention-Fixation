def f(ls, n)
    answer = 0
    ls.each do |i|
        if i[0] == n
            answer = i
        end
    end
    answer
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([1, 9, 4], candidate.call([[1, 9, 4], [83, 0, 5], [9, 6, 100]], 1))
  end
end
