def f(array)
    s = ' '
    s += array.join('')
    s
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("           ", candidate.call([" ", "  ", "    ", "   "]))
  end
end
