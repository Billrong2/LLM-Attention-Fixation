def f(n)
    n = n.to_s
    n[0] + '.' + n[1..-1].tr('-', '_')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("f.irst_second_third", candidate.call("first-second-third"))
  end
end
