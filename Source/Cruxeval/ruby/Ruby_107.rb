def f(text)
    result = []
    text.each_char do |char|
        if !char.ascii_only?
            return false
        elsif char.match?(/[[:alnum:]]/)
            result << char.upcase
        else
            result << char
        end
    end
    result.join('')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("UA6HAJQ", candidate.call("ua6hajq"))
  end
end
