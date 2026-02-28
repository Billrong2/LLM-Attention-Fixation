def f(sequence, value)
    i = [0, sequence.index(value) - sequence.length / 3].max
    result = ""
    sequence[i..-1].each_char.with_index do |v, j|
        if v == "+"
            result += value
        else
            result += sequence[i + j]
        end
    end
    result
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("hosu", candidate.call("hosu", "o"))
  end
end
