def f(s, c)
    s = s.split(' ')
    ((c + "  ") + (s.reverse.join('  ')))
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("*  There  Hello", candidate.call("Hello There", "*"))
  end
end
