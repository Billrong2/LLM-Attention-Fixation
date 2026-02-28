def f(string)
    if string.match?(/^\p{Alnum}+$/)
        "ascii encoded is allowed for this language"
    else
        "more than ASCII"
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("more than ASCII", candidate.call("Str zahrnuje anglo-ameriæske vasi piscina and kuca!"))
  end
end
