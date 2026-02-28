def f(n)
    t = 0
    b = ''
    digits = n.to_s.split('').map(&:to_i)
    digits.each do |d|
        if d == 0
            t += 1
        else
            break
        end
    end
    t.times do
        b += '1' + '0' + '4'
    end
    b += n.to_s
    return b
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("372359", candidate.call(372359))
  end
end
