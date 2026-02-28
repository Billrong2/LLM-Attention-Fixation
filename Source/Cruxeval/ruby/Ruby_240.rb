def f(float_number)
    number = float_number.to_s
    dot = number.index('.')
    if dot != nil
        return number[0...dot] + '.' + number[dot+1...number.length].ljust(2, '0')
    end
    return number + '.00'
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("3.121", candidate.call(3.121))
  end
end
