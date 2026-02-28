def f(text, suffix)
    output = text
    while text.end_with?(suffix)
        output = text[0...-suffix.length]
        text = output
    end
    output
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("!klcd!ma:ri", candidate.call("!klcd!ma:ri", "!"))
  end
end
