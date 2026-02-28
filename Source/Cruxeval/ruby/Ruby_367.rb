def f(nums, rmvalue)
    res = nums.dup
    while res.include?(rmvalue)
        popped = res.delete_at(res.index(rmvalue))
        res.push(popped) if popped != rmvalue
    end
    res
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([6, 2, 1, 1, 4, 1], candidate.call([6, 2, 1, 1, 4, 1], 5))
  end
end
