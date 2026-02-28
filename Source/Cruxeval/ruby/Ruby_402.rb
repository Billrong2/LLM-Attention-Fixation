def f(n, l)
    archive = {}
    n.times do
        archive.clear
        l.each { |x| archive[x + 10] = x * 10 }
    end
    archive
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({}, candidate.call(0, ["aaa", "bbb"]))
  end
end
