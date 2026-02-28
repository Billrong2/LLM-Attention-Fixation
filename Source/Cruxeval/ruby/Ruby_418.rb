def f(s, p)
    arr = s.partition(p)
    part_one, part_two, part_three = arr[0].length, arr[1].length, arr[2].length
    if part_one >= 2 && part_two <= 2 && part_three >= 2
        return (arr[0].reverse + arr[1] + arr[2].reverse + '#')
    end
    return (arr[0] + arr[1] + arr[2])
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("qqqqq", candidate.call("qqqqq", "qqq"))
  end
end
