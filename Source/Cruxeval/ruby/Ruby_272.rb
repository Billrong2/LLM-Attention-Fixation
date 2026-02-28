def f(base_list, nums)
    res = base_list + nums
    res_copy = res.dup
    (-nums.length..-1).each do |i|
        res_copy << res_copy[i]
    end
    res_copy
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([9, 7, 5, 3, 1, 2, 4, 6, 8, 0, 2, 6, 0, 6, 6], candidate.call([9, 7, 5, 3, 1], [2, 4, 6, 8, 0]))
  end
end
