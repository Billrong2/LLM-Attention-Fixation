def f(string)
    if string.upcase == string
        string.downcase
    elsif string.downcase == string
        string.upcase
    else
        string
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("cA", candidate.call("cA"))
  end
end
