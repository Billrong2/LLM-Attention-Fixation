def f(lst)
    res = []
    lst.each do |num|
        if num % 2 == 0
            res << num
        end
    end
    lst.dup
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([1, 2, 3, 4], candidate.call([1, 2, 3, 4]))
  end
end
