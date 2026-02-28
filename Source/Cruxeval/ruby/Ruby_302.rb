def f(string)
    string.gsub('needles', 'haystacks')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("wdeejjjzsjsjjsxjjneddaddddddefsfd", candidate.call("wdeejjjzsjsjjsxjjneddaddddddefsfd"))
  end
end
