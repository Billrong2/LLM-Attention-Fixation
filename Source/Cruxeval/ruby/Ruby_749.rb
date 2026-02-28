def f(text, width)
    result = ""
    lines = text.split("\n")
    lines.each do |l|
        result += l.center(width)
        result += "\n"
    end

    # Remove the very last empty line
    result = result[0...-1]
    result
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("l 
l ", candidate.call("l
l", 2))
  end
end
