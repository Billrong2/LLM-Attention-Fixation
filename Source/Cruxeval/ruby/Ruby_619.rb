def f(title)
    title.downcase
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("   rock   paper   scissors  ", candidate.call("   Rock   Paper   SCISSORS  "))
  end
end
