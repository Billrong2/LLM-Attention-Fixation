def f(text)
    if text.match?(/^\d+$/)
        'yes'
    else
        'no'
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("no", candidate.call("abc"))
  end
end
