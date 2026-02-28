def f(dct)
    lst = []
    sorted_keys = dct.keys.sort
    sorted_keys.each do |key|
        lst << [key, dct[key]]
    end
    lst
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([["a", 1], ["b", 2], ["c", 3]], candidate.call({"a" => 1, "b" => 2, "c" => 3}))
  end
end
