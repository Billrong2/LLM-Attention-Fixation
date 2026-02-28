def f(s, sep)
    sep_index = s.index(sep)
    prefix = s[0...sep_index]
    middle = s[sep_index...(sep_index + sep.length)]
    right_str = s[(sep_index + sep.length)..]
    return prefix, middle, right_str
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(["", "", "not it"], candidate.call("not it", ""))
  end
end
