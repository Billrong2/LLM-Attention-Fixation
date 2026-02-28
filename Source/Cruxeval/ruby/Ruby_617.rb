def f(text)
    if text.ascii_only?
        'ascii'
    else
        'non ascii'
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("ascii", candidate.call("<<<<"))
  end
end
