def f(lst)
  (lst.length - 1).downto(1) do |i|
    (0...i).each do |j|
      if lst[j] > lst[j + 1]
        lst[j], lst[j + 1] = lst[j + 1], lst[j]
        lst.sort!
      end
    end
  end
  lst
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([0, 0, 1, 4, 5, 7, 9, 25, 63, 87], candidate.call([63, 0, 1, 5, 9, 87, 0, 7, 25, 4]))
  end
end
