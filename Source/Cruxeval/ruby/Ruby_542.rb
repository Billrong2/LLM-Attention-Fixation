def f(test, sep = ' ', maxsplit = -1)
  begin
    return test.split(sep, -maxsplit)
  rescue
    return test.split
  end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(["ab cd"], candidate.call("ab cd", "x", 2))
  end
end
