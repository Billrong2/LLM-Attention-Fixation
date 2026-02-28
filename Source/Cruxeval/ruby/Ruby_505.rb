def f(string)
    while string.length > 0
        if string[-1].match?(/\p{Alpha}/)
            return string
        end
        string = string.chop
    end
    return string
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("", candidate.call("--4/0-209"))
  end
end
