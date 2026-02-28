def f(text, characters)
  characters.split('').each do |char|
    text = text.chomp(char)
  end
  text
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("r;r;r;r;r;r;r;r;", candidate.call("r;r;r;r;r;r;r;r;r", "x.r"))
  end
end
