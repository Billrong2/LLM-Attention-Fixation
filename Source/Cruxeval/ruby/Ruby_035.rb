def f(pattern, items)
    result = []
    items.each do |text|
        pos = text.rindex(pattern)
        result << pos if pos
    end
    result
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([], candidate.call(" B ", [" bBb ", " BaB ", " bB", " bBbB ", " bbb"]))
  end
end
