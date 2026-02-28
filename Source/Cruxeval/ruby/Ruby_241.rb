def f(postcode)
    postcode[postcode.index('C')..]
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("CW", candidate.call("ED20 CW"))
  end
end
