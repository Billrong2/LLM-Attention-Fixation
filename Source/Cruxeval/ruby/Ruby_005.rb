def f(text, lower, upper)
    count = 0
    new_text = []
    text.each_char do |char|
        char = char.match?(/\d/) ? lower : upper
        if char == 'p' || char == 'C'
            count += 1
        end
        new_text << char
    end
    return count, new_text.join('')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([0, "xxxxxxxxxxxxxxxxxx"], candidate.call("DSUWeqExTQdCMGpqur", "a", "x"))
  end
end
