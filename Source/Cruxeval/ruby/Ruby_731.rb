def f(text, use)
    text.gsub(use, '')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("Chris requires  ride to the irport on Fridy.", candidate.call("Chris requires a ride to the airport on Friday.", "a"))
  end
end
