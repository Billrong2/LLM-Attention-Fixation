def f(a, b, n)
    result = m = b
    n.times do
        if m
            a, m = a.sub(m, ''), nil
            result = m = b
        end
    end
    return a.split(b).join(result)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("unrndqafi", candidate.call("unrndqafi", "c", 2))
  end
end
