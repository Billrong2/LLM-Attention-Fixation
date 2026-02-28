def f(s)
    nums = s.scan(/\d/).join('')
    return 'none' if nums.empty?
    m = nums.split(',').map(&:to_i).max
    m.to_s
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("1001", candidate.call("01,001"))
  end
end
