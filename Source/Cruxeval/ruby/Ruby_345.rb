def f(a, b)
    if a < b
        return [b, a]
    end
    [a, b]
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(["mv", "ml"], candidate.call("ml", "mv"))
  end
end
