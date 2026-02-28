def f(text)
    out = ""
    text.each_char do |char|
        if char == char.upcase
            out += char.downcase
        else
            out += char.upcase
        end
    end
    out
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(",WpZpPPDL/", candidate.call(",wPzPppdl/"))
  end
end
