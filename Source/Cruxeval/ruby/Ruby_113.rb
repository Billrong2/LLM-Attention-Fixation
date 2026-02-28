def f(line)
    count = 0
    a = []
    line.each_char.with_index do |char, i|
        count += 1
        if count % 2 == 0
            a << char.swapcase
        else
            a << char
        end
    end
    a.join('')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("987YhnShAShD 93275yRgsgBgssHfBsFB", candidate.call("987yhNSHAshd 93275yrgSgbgSshfbsfB"))
  end
end
