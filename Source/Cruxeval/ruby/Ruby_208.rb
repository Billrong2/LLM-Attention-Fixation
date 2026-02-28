def f(items)
    result = []
    items.each do |item|
        item.each_char do |d|
            result << d unless d.match?(/\d/)
        end
    end
    result
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(["c", "a", "t", "d", " ", "d", "e", "e"], candidate.call(["123", "cat", "d dee"]))
  end
end
