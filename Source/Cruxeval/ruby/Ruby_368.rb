def f(string, numbers)
    arr = []
    numbers.each do |num|
        arr << string.rjust(num, '0')
    end
    arr.join(' ')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("4327 00004327 000004327 4327 0004327 4327", candidate.call("4327", [2, 8, 9, 2, 7, 1]))
  end
end
