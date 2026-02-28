def f(text, char)
    new_text = text
    a = []
    while new_text.include?(char)
        a << new_text.index(char)
        new_text = new_text.sub(char, "")
    end
    a
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([0, 1], candidate.call("rvr", "r"))
  end
end
