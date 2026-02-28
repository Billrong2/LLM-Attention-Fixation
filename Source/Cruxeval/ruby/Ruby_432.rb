require 'set'

def f(length, text)
    if text.length == length
        text.reverse
    else
        false
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(false, candidate.call(-5, "G5ogb6f,c7e.EMm"))
  end
end
