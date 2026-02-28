def f(text)
    result = ''
    i = text.length - 1
    while i >= 0
        c = text[i]
        if c.match?(/[a-zA-Z]/)
            result += c
        end
        i -= 1
    end
    result
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("qozx", candidate.call("102x0zoq"))
  end
end
