def f(integer, n)
    i = 1
    text = integer.to_s
    while (i + text.length < n)
        i += text.length
    end
    text.rjust(i + text.length, '0')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("08999", candidate.call(8999, 2))
  end
end
