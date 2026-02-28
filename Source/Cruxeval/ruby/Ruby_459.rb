def f(arr, d)
    (1...arr.length).step(2) do |i|
        d[arr[i]] = arr[i-1]
    end
    d
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({"vzjmc" => "b", "ae" => "f"}, candidate.call(["b", "vzjmc", "f", "ae", "0"], {}))
  end
end
