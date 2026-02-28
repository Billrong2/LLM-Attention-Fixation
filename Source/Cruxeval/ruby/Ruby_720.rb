def f(items, item)
    items.pop while items[-1] == item
    items.push(item)
    items.length
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(2, candidate.call(["bfreratrrbdbzagbretaredtroefcoiqrrneaosf"], "n"))
  end
end
