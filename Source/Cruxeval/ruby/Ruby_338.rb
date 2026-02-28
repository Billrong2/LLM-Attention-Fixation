def f(my_dict)
  result = my_dict.invert
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({1 => "a", 2 => "d", 3 => "c"}, candidate.call({"a" => 1, "b" => 2, "c" => 3, "d" => 2}))
  end
end
