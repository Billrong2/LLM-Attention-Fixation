def f(values, item1, item2)
  if values[-1] == item2
    if !values[1..-1].include?(values[0])
      values << values[0]
    end
  elsif values[-1] == item1
    if values[0] == item2
      values << values[0]
    end
  end
  values
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([1, 1], candidate.call([1, 1], 2, 3))
  end
end
