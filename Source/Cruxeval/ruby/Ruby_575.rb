def f(nums, val)
    new_list = []
    nums.each { |i| val.times { new_list << i } }
    new_list.sum
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(42, candidate.call([10, 4], 3))
  end
end
