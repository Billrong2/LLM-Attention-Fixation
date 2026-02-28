def f(a, b, c)
    result = {}
    [a, b, c].each do |d|
        result.merge!(d.to_h { |key| [key, nil] })
    end
    result
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({1 => nil, 2 => nil, 3 => nil, 4 => nil}, candidate.call([1, 3], [1, 4], [1, 2]))
  end
end
