def f(text)
    if text.match(/[a-z]/) && text == text.downcase
        return true
    end
    return false
end

require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(false, candidate.call("54882"))
  end
end
