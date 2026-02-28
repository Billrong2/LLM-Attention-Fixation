def f(lst)
    new = []
    i = lst.length - 1
    lst.length.times do
        if i % 2 == 0
            new << -lst[i]
        else
            new << lst[i]
        end
        i -= 1
    end
    new
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([-3, 1, 7, -1], candidate.call([1, 7, -1, -3]))
  end
end
