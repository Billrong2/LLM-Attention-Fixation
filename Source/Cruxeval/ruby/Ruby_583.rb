def f(text, ch)
    result = []
    text.split("\n").each do |line|
        if line.length > 0 && line[0] == ch
            result << line.downcase
        else
            result << line.upcase
        end
    end
    result.join("\n")
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("t
ZA
A", candidate.call("t
za
a", "t"))
  end
end
