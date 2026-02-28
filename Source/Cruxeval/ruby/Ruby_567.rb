def f(s, n)
  ls = s.split(' ')
  out = []
  
  while ls.length >= n
    out += ls.last(n)
    ls = ls[0...-n]
  end
  
  ls << out.join('_')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(["one", "two", "three_four_five"], candidate.call("one two three four five", 3))
  end
end
