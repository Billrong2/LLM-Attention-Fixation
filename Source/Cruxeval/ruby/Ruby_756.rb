def f(text)
    if text.match?(/^\d+$/)
        'integer'
    else
        'string'
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("string", candidate.call(""))
  end
end
