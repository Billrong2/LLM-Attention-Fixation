def f(text)
    result = []
    text.each_char.with_index do |ch, i|
        next if ch == ch.downcase
        if text.length - 1 - i < text.rindex(ch.downcase)
            result << ch
        end
    end
    result.join('')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("", candidate.call("ru"))
  end
end
