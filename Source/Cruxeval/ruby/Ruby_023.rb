def f(text, chars)
  if chars != ''
    text = text.rstrip.chars.reverse.drop_while{|i| chars.include? i}.reverse.join
  else
    text = text.rstrip
  end
  return text == '' ? '-' : text
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("new-medium-performing-application - XQuery 2.", candidate.call("new-medium-performing-application - XQuery 2.2", "0123456789-"))
  end
end
