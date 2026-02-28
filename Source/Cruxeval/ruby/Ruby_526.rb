def f(label1, char, label2, index)
    m = label1.rindex(char)
    if m >= index
        return label2[0..m - index]
    end
    return label1 + label2[index - m - 1..-1]
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("rpg", candidate.call("ekwies", "s", "rpg", 1))
  end
end
