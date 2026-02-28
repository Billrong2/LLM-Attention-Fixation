def f(nums, fill)
    ans = Hash[nums.zip([fill] * nums.length)]
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({0 => "abcca", 1 => "abcca", 2 => "abcca"}, candidate.call([0, 1, 1, 2], "abcca"))
  end
end
