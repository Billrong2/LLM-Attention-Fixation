def f(x)
    a = 0
    x.split.each do |i|
        a += i.size.to_s.rjust(i.size*2, '0').size
    end
    a
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(30, candidate.call("999893767522480"))
  end
end
