def f(plot, delin)
    if plot.include?(delin)
        split = plot.index(delin)
        first = plot[0...split]
        second = plot[split + 1..-1]
        return first + second
    else
        return plot
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([1, 2, 4], candidate.call([1, 2, 3, 4], 3))
  end
end
