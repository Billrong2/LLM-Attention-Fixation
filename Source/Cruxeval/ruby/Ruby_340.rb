def f(text)
    uppercase_index = text.index('A') || text.index('a')
    if uppercase_index
        text[0...uppercase_index] + text[(uppercase_index + 1)..]
    else
        text.chars.sort.join
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("   DEGHIVjkptx", candidate.call("E jIkx HtDpV G"))
  end
end
