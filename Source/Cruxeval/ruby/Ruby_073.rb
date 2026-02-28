def f(row)
    [row.count('1'), row.count('0')]
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([3, 6], candidate.call("100010010"))
  end
end
