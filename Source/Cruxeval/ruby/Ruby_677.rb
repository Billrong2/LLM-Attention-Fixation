def f(text, length)
    length = -length if length < 0
    output = ''
    length.times do |idx|
        if text[idx % text.length] != ' '
            output += text[idx % text.length]
        else
            break
        end
    end
    output
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("I", candidate.call("I got 1 and 0.", 5))
  end
end
