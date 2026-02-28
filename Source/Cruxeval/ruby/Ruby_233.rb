def f(xs)
    xs.length.times do |idx|
        xs.unshift(xs.pop)
    end
    xs
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([1, 2, 3], candidate.call([1, 2, 3]))
  end
end
