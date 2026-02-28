def f(tap_hierarchy)
    hierarchy = {}
    tap_hierarchy.each do |gift|
        hierarchy = gift.split('').to_h { |key| [key, nil] }
    end
    hierarchy
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({"d" => nil, "o" => nil, "e" => nil}, candidate.call(["john", "doe", "the", "john", "doe"]))
  end
end
