def f(d, index)
  length = d.length
  idx = index % length
  v = d.shift[1]
  idx.times { d.shift }
  v
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(39, candidate.call({27 => 39}, 1))
  end
end
