def f(xaaxx, s)
    count = 0
    idx = -1
    while xaaxx.index('XXXX', idx+1)
        idx = xaaxx.index('XXXX', idx+1) 
        count += 1 
    end
    compound = count.times.map { s.capitalize }.join
    xaaxx.gsub('XXXX', compound)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("aaQwQwQwbbQwQwQwccQwQwQwde", candidate.call("aaXXXXbbXXXXccXXXXde", "QW"))
  end
end
