def f(s)
    if s.match?(/\A[a-zA-Z]+\z/)
        "yes"
    elsif s.empty?
        "str is empty"
    else
        "no"
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("yes", candidate.call("Boolean"))
  end
end
