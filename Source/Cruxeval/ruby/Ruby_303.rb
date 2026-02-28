def f(text)
  i = (text.length + 1) / 2
  result = text.split('')
  while i < text.length
    t = result[i].downcase
    if t == result[i]
      i += 1
    else
      result[i] = t
    end
    i += 2
  end
  result.join('')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("mJklbn", candidate.call("mJkLbn"))
  end
end
