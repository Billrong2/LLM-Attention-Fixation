def f(lst, start, finish)
  count = 0
  (start...finish).each do |i|
    (i...finish).each do |j|
      if lst[i] != lst[j]
        count += 1
      end
    end
  end
  count
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(3, candidate.call([1, 2, 4, 3, 2, 1], 0, 3))
  end
end
