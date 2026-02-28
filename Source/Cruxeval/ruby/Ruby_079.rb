def f(arr)
  arr.clear
  arr << '1'
  arr << '2'
  arr << '3'
  arr << '4'
  arr.join(',')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("1,2,3,4", candidate.call([0, 1, 2, 3, 4]))
  end
end
