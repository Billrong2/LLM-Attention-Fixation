def f(items, target)
    if items.include?(target)
        return items.index(target)
    else
        return -1
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(3, candidate.call(["1", "+", "-", "**", "//", "*", "+"], "**"))
  end
end
