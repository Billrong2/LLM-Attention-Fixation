def f(nums)
  copy = nums.dup
  new_dict = {}
  copy.each do |k, v|
    new_dict[k] = v.length
  end
  new_dict
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({}, candidate.call({}))
  end
end
