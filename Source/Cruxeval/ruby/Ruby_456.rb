def f(s, tab)
    s.gsub(/\t/, ' '*tab)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("Join us in Hungary", candidate.call("Join us in Hungary", 4))
  end
end
