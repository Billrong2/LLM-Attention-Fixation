def f(ip, n)
    i = 0
    out = ''
    ip.each_char do |c|
        if i == n
            out += "\n"
            i = 0
        end
        i += 1
        out += c
    end
    out
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("dskj
s hj
cdjn
xhji
cnn", candidate.call("dskjs hjcdjnxhjicnn", 4))
  end
end
