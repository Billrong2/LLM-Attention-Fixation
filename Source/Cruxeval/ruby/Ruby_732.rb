def f(char_freq)
    result = {}
    char_freq.each do |k, v|
        result[k] = v / 2
    end
    result
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({"u" => 10, "v" => 2, "b" => 3, "w" => 1, "x" => 1}, candidate.call({"u" => 20, "v" => 5, "b" => 7, "w" => 3, "x" => 3}))
  end
end
