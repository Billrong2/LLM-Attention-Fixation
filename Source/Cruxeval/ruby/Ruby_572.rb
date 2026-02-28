def f(data, num)
    new_dict = {}
    temp = data.to_a
    (temp.length - 1).downto(num) do |i|
        new_dict[temp[i]] = nil
    end
    temp[num..] + new_dict.to_a
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([[2, 10], [3, 1], [[3, 1], nil], [[2, 10], nil]], candidate.call({1 => 9, 2 => 10, 3 => 1}, 1))
  end
end
