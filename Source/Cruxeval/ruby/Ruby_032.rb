def f(s, sep)
  reverse = s.split(sep).map { |e| '*' + e }
  reverse.reverse.join(';')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("*ume;*vo", candidate.call("volume", "l"))
  end
end
