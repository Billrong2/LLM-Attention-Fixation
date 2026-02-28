def f(num)
    num << num[-1]
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([-70, 20, 9, 1, 1], candidate.call([-70, 20, 9, 1]))
  end
end
