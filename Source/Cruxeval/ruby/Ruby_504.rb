def f(values)
    values.sort!
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([1, 1, 1, 1], candidate.call([1, 1, 1, 1]))
  end
end
