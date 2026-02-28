def f(num, l)
    t = ""
    while l > num.length
        t += '0'
        l -= 1
    end
    t + num
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("001", candidate.call("1", 3))
  end
end
