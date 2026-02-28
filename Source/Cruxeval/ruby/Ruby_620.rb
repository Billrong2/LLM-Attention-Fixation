def f(x)
    x.chars.to_a.reverse.join(' ')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("3 i h o x m q d n   a n d   t r e l", candidate.call("lert dna ndqmxohi3"))
  end
end
