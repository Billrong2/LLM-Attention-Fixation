def f(text)
    return false if text == ''
    first_char = text[0]
    return false if text[0].match?(/\d/)
    text.each_char do |last_char|
        return false if (last_char != '_') && !last_char.match?(/[[:alnum:]_]/)
    end
    true
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(true, candidate.call("meet"))
  end
end
