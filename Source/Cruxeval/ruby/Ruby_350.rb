def f(d)
    size = d.size
    v = Array.new(size, 0)
    return v if size == 0
    
    d.values.each_with_index do |e, i|
        v[i] = e
    end
    
    v
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([1, 2, 3], candidate.call({"a" => 1, "b" => 2, "c" => 3}))
  end
end
