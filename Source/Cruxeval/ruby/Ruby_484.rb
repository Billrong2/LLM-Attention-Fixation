def f(arr)
    result = []
    arr.each do |item|
        begin
            if item.match?(/^\d+$/)
                result << item.to_i * 2
            end
        rescue
            result << item.reverse
        end
    end
    result
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([182, 32], candidate.call(["91", "16", "6r", "5r", "egr", "", "f", "q1f", "-2"]))
  end
end
