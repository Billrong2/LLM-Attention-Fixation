def f(dict)
    result = dict.dup
    dict.each do |k, v|
        if result[v]
            result.delete(k)
        end
    end
    result
end

require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({3 => 6}, candidate.call({-1 => -1, 5 => 5, 3 => 6, -4 => -4}))
  end
end
