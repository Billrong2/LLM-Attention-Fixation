def f(dict)
    even_keys = []
    dict.keys.each do |key|
        if key % 2 == 0
            even_keys << key
        end
    end
    even_keys
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([4], candidate.call({4 => "a"}))
  end
end
