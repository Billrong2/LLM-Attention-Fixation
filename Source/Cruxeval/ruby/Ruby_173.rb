def f(list_x)
    item_count = list_x.length
    new_list = []
    item_count.times do
        new_list.push(list_x.pop)
    end
    new_list
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([4, 8, 6, 8, 5], candidate.call([5, 8, 6, 8, 4]))
  end
end
