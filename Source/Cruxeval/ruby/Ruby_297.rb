def f(num)
    if num > 0 && num < 1000 && num != 6174
        return 'Half Life'
    end
    return 'Not found'
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("Not found", candidate.call(6173))
  end
end
