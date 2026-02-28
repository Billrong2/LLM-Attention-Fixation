def f(text1, text2)
    nums = []
    text2.chars.each do |char|
        nums.append(text1.count(char))
    end
    nums.sum
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(2, candidate.call("jivespdcxc", "sx"))
  end
end
