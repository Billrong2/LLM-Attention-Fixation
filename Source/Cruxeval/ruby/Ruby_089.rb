def f(char)
    if !['a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U'].include?(char)
        return nil
    end
    if ['A', 'E', 'I', 'O', 'U'].include?(char)
        return char.downcase
    end
    return char.upcase
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("O", candidate.call("o"))
  end
end
