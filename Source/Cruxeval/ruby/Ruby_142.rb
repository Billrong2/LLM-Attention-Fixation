def f(x)
    if x.downcase == x
        x
    else
        x.reverse
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("ykdfhp", candidate.call("ykdfhp"))
  end
end
