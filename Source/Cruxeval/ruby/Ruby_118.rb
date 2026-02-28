def f(text, chars)
    num_applies = 2
    extra_chars = ''
    num_applies.times do
        extra_chars += chars
        text.gsub!(extra_chars, '')
    end
    text
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("zbzquiuqnmfkx", candidate.call("zbzquiuqnmfkx", "mk"))
  end
end
