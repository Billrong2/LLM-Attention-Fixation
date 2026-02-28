def f(text)
    text = text.downcase
    capitalize = text.capitalize
    text[0] + capitalize[1..-1]
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("this and cpanel", candidate.call("this And cPanel"))
  end
end
