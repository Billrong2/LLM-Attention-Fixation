def f(base, delta)
  delta.each do |pair|
    base.each_with_index do |value, index|
      if value == pair[0]
        raise "Error: #{pair[1]} is the same as #{value}" if pair[1] == value
        base[index] = pair[1]
      end
    end
  end
  base
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(["gloss", "banana", "barn", "lawn"], candidate.call(["gloss", "banana", "barn", "lawn"], []))
  end
end
