def f(d, count)
    count.times do
        break if d.empty?
        d.shift
    end
    d
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({}, candidate.call({}, 200))
  end
end
