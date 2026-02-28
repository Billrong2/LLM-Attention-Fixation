def f(string)
  tmp = string.downcase
  string.downcase.each_char do |char|
    if tmp.include?(char)
      tmp = tmp.sub(char, '')
    end
  end
  tmp
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("", candidate.call("[ Hello ]+ Hello, World!!_ Hi"))
  end
end
