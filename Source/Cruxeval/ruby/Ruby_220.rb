def f(text, m, n)
  text = "#{text}#{text[0, m]}#{text[n, text.length]}"
  result = ""
  (n...(text.length - m)).each do |i|
    result = text[i] + result
  end
  return result
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("bagfedcacbagfedc", candidate.call("abcdefgabc", 1, 2))
  end
end
