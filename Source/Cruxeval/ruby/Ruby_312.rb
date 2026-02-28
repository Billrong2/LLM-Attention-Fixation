def f(s)
    if s.match?(/\A\p{Alnum}+\z/)
        "True"
    else
        "False"
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("True", candidate.call("777"))
  end
end
