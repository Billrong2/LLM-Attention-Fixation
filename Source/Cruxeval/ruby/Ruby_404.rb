def f(no)
    d = no.to_h { |key| [key, false] }
    d.keys.count
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(6, candidate.call(["l", "f", "h", "g", "s", "b"]))
  end
end
