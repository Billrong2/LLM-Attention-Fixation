def f(text, prefix)
    while text.start_with?(prefix)
        text = text[prefix.length..-1].empty? ? text : text[prefix.length..-1]
    end
    text
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("dbtdabdahesyehu", candidate.call("ndbtdabdahesyehu", "n"))
  end
end
