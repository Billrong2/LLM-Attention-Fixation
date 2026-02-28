def f(text)
    begin
        text.match?(/\A[a-zA-Z]+\z/)
    rescue
        false
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(true, candidate.call("x"))
  end
end
