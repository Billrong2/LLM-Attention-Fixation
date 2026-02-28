def f(d)
  result = {}
  d.each do |ki, li|
    result[ki] = []
    li.each_with_index do |dj, kj|
      result[ki][kj] = {}
      dj.each do |kk, l|
        result[ki][kj][kk] = l.dup
      end
    end
  end
  result
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({}, candidate.call({}))
  end
end
