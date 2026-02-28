def f(text)
    new_text = text
    while text.length > 1 && text[0] == text[-1]
        new_text = text = text[1...-1]
    end
    new_text
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(")", candidate.call(")"))
  end
end
