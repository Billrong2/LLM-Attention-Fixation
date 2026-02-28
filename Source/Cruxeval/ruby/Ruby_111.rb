def f(marks)
  highest = 0
  lowest = 100
  marks.values.each do |value|
    highest = value if value > highest
    lowest = value if value < lowest
  end
  [highest, lowest]
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([89, 4], candidate.call({"x" => 67, "v" => 89, "" => 4, "alij" => 11, "kgfsd" => 72, "yafby" => 83}))
  end
end
