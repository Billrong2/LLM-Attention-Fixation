def f(text, prefix)
    idx = 0
    prefix.each_char do |letter|
        return nil if text[idx] != letter
        idx += 1
    end
    return text[idx..-1]
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("", candidate.call("bestest", "bestest"))
  end
end
