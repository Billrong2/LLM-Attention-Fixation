def f(number)
    transl = {'A' => 1, 'B' => 2, 'C' => 3, 'D' => 4, 'E' => 5}
    result = []
    transl.each do |key, value|
        result << key if value % number == 0
    end
    result
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(["B", "D"], candidate.call(2))
  end
end
