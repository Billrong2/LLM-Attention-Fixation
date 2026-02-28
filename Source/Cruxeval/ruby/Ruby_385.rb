def f(lst)
    i = 0
    new_list = []
    while i < lst.length
        if lst[i] == lst[i+1..-1].find { |x| x == lst[i] }
            new_list << lst[i]
            return new_list if new_list.length == 3
        end
        i += 1
    end
    new_list
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([0, 2, 2], candidate.call([0, 2, 1, 2, 6, 2, 6, 3, 0]))
  end
end
