def f(text, search_string)
    indexes = []
    while text.include?(search_string)
        indexes << text.rindex(search_string)
        text = text[0...text.rindex(search_string)]
    end
    indexes
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([28, 19, 12, 6], candidate.call("ONBPICJOHRHDJOSNCPNJ9ONTHBQCJ", "J"))
  end
end
