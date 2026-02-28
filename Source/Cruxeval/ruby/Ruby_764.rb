def f(text, old, new)
    text2 = text.gsub(old, new)
    old2 = old.reverse
    while text2.include?(old2)
        text2 = text2.gsub(old2, new)
    end
    text2
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("any test string", candidate.call("some test string", "some", "any"))
  end
end
