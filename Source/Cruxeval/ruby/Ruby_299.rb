def f(text, char)
    unless text.end_with?(char)
        return f(char + text, char)
    end
    return text
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("staovk", candidate.call("staovk", "k"))
  end
end
