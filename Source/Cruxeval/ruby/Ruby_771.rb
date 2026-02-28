def f(items)
    items = items.to_a
    odd_positioned = []
    while items.length > 0
        position = items.index(items.min)
        items.delete_at(position)
        item = items.delete_at(position)
        odd_positioned.push(item)
    end
    odd_positioned
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([2, 4, 6, 8], candidate.call([1, 2, 3, 4, 5, 6, 7, 8]))
  end
end
