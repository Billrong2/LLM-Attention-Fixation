def f(num)
    s = '<' * 10
    if num % 2 == 0
        s
    else
        num - 1
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(20, candidate.call(21))
  end
end
