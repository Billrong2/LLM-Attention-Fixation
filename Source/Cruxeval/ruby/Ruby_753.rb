def f(bag)
    values = bag.values
    tbl = {}
    (0..99).each do |v|
        if values.include?(v)
            tbl[v] = values.count(v)
        end
    end
    tbl
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({0 => 5}, candidate.call({0 => 0, 1 => 0, 2 => 0, 3 => 0, 4 => 0}))
  end
end
