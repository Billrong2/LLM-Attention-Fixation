def f(text)
    new_text = ''
    text.downcase.strip.each_char do |ch|
        if ch.match?(/\d/) || ch.match?(/[ÄäÏïÖöÜü]/)
            new_text += ch
        end
    end
    new_text
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("", candidate.call(""))
  end
end
