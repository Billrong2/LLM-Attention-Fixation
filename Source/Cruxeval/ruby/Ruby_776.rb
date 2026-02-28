def f(dictionary)
    a = dictionary.dup
    a.each do |key, value|
        if key % 2 != 0
            a.delete(key)
            a['$' + key.to_s] = value
        end
    end
    a
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({}, candidate.call({}))
  end
end
