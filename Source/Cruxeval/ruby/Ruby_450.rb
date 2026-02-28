def f(strs)
    strs = strs.split
    (1...strs.length).step(2) do |i|
        strs[i] = strs[i].reverse
    end
    strs.join(' ')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("K KBz", candidate.call("K zBK"))
  end
end
