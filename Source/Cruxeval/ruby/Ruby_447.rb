def f(text, tab_size)
  res = ''
  text = text.gsub("\t", ' '*(tab_size-1))
  text.each_char do |char|
    if char == ' '
      res += '|'
    else
      res += char
    end
  end
  res
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("||a", candidate.call("	a", 3))
  end
end
