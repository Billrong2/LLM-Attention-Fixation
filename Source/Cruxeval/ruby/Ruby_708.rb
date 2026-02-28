def f(string)
    l = string.split('')
    (l.length - 1).downto(0) do |i|
        if l[i] != ' '
            break
        end
        l.delete_at(i)
    end
    l.join('')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("    jcmfxv", candidate.call("    jcmfxv     "))
  end
end
