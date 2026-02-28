def f(dct)
    values = dct.values
    result = {}
    values.each do |value|
        item = value.split('.')[0] + '@pinc.uk'
        result[value] = item
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
