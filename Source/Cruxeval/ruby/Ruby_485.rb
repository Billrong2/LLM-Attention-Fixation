def f(tokens)
    tokens = tokens.split
    tokens = tokens.reverse if tokens.length == 2
    result = "#{tokens[0].ljust(5)} #{tokens[1].ljust(5)}"
    return result
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("avdropj gsd  ", candidate.call("gsd avdropj"))
  end
end
