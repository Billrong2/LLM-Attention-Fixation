def f(n)
    p = ''
    if n % 2 == 1
        p += 'sn'
    else
        return n * n
    end
    (1..n).each do |x|
        if x % 2 == 0
            p += 'to'
        else
            p += 'ts'
        end
    end
    return p
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("snts", candidate.call(1))
  end
end
