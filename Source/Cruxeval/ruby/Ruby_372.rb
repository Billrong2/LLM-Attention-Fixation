def f(list_, num)
  temp = []
  list_.each do |i|
    i = '%s,' % i * (num / 2)
    temp.append(i)
  end
  temp
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([""], candidate.call(["v"], 1))
  end
end
