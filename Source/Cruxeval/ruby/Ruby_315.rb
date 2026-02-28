def f(challenge)
    challenge.downcase.gsub('l', ',')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("czywz", candidate.call("czywZ"))
  end
end
