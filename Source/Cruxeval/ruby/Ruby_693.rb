def f(text)
    n = text.index('8')
    'x0' * n
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("x0x0", candidate.call("sa832d83r xd 8g 26a81xdf"))
  end
end
