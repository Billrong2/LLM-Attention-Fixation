def f(d, get_ary)
    result = []
    get_ary.each do |key|
        result << d[key]
    end
    result
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(["swims like a bull", nil, nil], candidate.call({3 => "swims like a bull"}, [3, 2, 5]))
  end
end
